import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/models/message_model.dart';
import 'package:neko_wallet/models/user_model.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/customerSupport/incoming_chat_item.dart';
import 'package:neko_wallet/widgets/customerSupport/message_composer.dart';
import 'package:neko_wallet/widgets/customerSupport/out_going_chat_item.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:neko_wallet/widgets/typing_indicator.dart';

class CustomerSupportScreen extends StatefulWidget {
  @override
  _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  UserModel _outgoingUser = UserModel(
      name: 'Neko Bot',
      imageUrl: 'assets/images/bot_customer_sp.png',
      id: "999");

  List<Message> _messages = [];

  final key = GlobalKey<AnimatedListState>();

  final _isSomeoneTyping = false.obs;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      _isSomeoneTyping.value = true;
    });

    Future.delayed(Duration(milliseconds: 2000), () {
      _isSomeoneTyping.value = false;

      final message = Message(
          isLiked: false,
          sender: _outgoingUser,
          unread: false,
          time: DateTime.now().millisecondsSinceEpoch,
          text: 'How may I help you today?');

      key.currentState?.insertItem(0);

      _messages.insert(0, message);
    });
  }

  _buildMessage(bool isMe, Message message, Animation<double> animation) {
    if (isMe) {
      return IncomingChatItem(message: message, animation: animation);
    }
    return OutgoingChatItem(
        message: message,
        user: _outgoingUser,
        onPressFavorite: (message) {
          message.isLiked = !message.isLiked;

          setState(() {});
        },
        animation: animation);
  }

  _onPressSend(String text) {
    if (text.trim().isEmpty) {
      return;
    }

    final message = Message(
        isLiked: false,
        sender: currentUser,
        unread: false,
        time: DateTime.now().millisecond,
        text: text);

    key.currentState?.insertItem(0);

    _messages.insert(0, message);
  }

  _didReceiveMessage(String userId, Message message) {
    if (userId == "999") {
      // Bot

      Future.delayed(Duration(milliseconds: 500), () {
        _isSomeoneTyping.value = true;
      });

      Future.delayed(Duration(milliseconds: 2000), () {
        _isSomeoneTyping.value = false;

        final message = Message(
            isLiked: false,
            sender: _outgoingUser,
            unread: false,
            time: DateTime.now().millisecondsSinceEpoch,
            text: 'How may I help you today?');

        key.currentState?.insertItem(0);

        _messages.insert(0, message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: Colors.white,
      child: Column(children: <Widget>[
        HeaderGradient(
          title: 'Customer Support',
          isCurved: false,
          gradient: makeLinearGradient(colors: AppColors.primaryGradientColors),
          leftIcon: CommonWidget.svgImage('ic_back_white'),
          onPressLeftIcon: () => Navigator.of(context).pop(),
          iconSize: 36,
          padding: EdgeInsets.only(
            left: 22.0,
            top: MediaQuery.of(context).padding.top > 20
                ? isAndroid()
                    ? MediaQuery.of(context).padding.top + 30
                    : MediaQuery.of(context).padding.top + 15
                : MediaQuery.of(context).padding.top + 30,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.white,
              child: AnimatedList(
                key: key,
                reverse: true,
                padding: EdgeInsets.only(top: 15.0),
                initialItemCount: _messages.length,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  final Message message = _messages[index];
                  final bool isMe = message.sender.id == currentUser.id;
                  return _buildMessage(isMe, message, animation);
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Obx(
            () => TypingIndicator(
              showIndicator: _isSomeoneTyping.value,
              bubbleColor: Colors.grey.shade100,
              flashingCircleDarkColor: Colors.grey.shade100,
            ),
          ),
        ),
        MessageComposer(
          onPressPhoto: () {},
          onPressSend: (text) => _onPressSend(text),
        ),
      ]),
    );
  }
}
