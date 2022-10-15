import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/date_time_formatter.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late UserModel _user;


  @override
  void initState() {
    super.initState();
    _user = Get.arguments as UserModel;
  }

  _buildMessageComposer() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 70.0,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo),
                iconSize: 25.0,
                color: Theme.of(context).primaryColor,
                onPressed: () => {}),
            Expanded(
                child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                  hintText: 'send_a_message'.tr + '...'),
            )),
            IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Theme.of(context).primaryColor,
                onPressed: () => {})
          ],
        ));
  }

  _buildMessage(bool isMe, Message message) {
    final msg = Container(
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color:
              isMe ? Theme.of(context).colorScheme.secondary : AppColors.white,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0))
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StyleText(
              text: DateTimeFormatter.shared
                  .timestampToString(timestamp: message.time),
              textColor: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
          SizedBox(height: 8.0),
          StyleText(
              text: message.text ?? "",
              textColor: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ],
      ),
    );

    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
            icon: message.isLiked
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            iconSize: 30.0,
            color: message.isLiked
                ? Theme.of(context).primaryColor
                : Colors.blueGrey,
            onPressed: () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: StyleText(
            text: _user.name ?? "",
            fontSize: 28.0,
            fontWeight: FontWeight.bold),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_horiz),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {})
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(isMe, message);
                  },
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
