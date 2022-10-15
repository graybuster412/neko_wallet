import 'package:flutter/material.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/message_model.dart';
import 'package:neko_wallet/models/user_model.dart';
import 'package:neko_wallet/utils/date_time_formatter.dart';
import 'package:neko_wallet/widgets/customerSupport/bubble_tail.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class OutgoingChatItem extends StatefulWidget {
  const OutgoingChatItem(
      {Key? key,
      required this.message,
      required this.user,
      required this.onPressFavorite,
      required this.animation})
      : super(key: key);

  final Message message;

  final UserModel user;

  final ValueChanged<Message> onPressFavorite;

  final Animation<double> animation;

  @override
  _OutgoingChatItemState createState() => _OutgoingChatItemState();
}

class _OutgoingChatItemState extends State<OutgoingChatItem>
    with TickerProviderStateMixin {
  late Animation _heartAnimation;

  late AnimationController _heartAnimationController;

  @override
  void initState() {
    super.initState();

    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));

    _heartAnimation = Tween(begin: 30.0, end: 32.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _heartAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: widget.user.imageUrl != null
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircleAvatar(
                      radius: 24 / 2,
                      backgroundImage: AssetImage(widget.user.imageUrl!),
                    ),
                  )
                : Container(),
          ),
          SizedBox(width: 5),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                        bottom: 10,
                        left: 5,
                        child: CustomPaint(
                          painter:
                              BubbleTail(bubbleColor: Colors.blueGrey.shade50),
                        )),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      padding: EdgeInsets.only(
                          left: 22.0, right: 12, top: 12.0, bottom: 12),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StyleText(
                              text: widget.user.name ?? "",
                              textColor: HexColor.fromHex('#353333'),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                          SizedBox(height: 5.0),
                          StyleText(
                              text: widget.message.text ?? "",
                              textColor: HexColor.fromHex('#353333'),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                          SizedBox(height: 2.0),
                          StyleText(
                              text: DateTimeFormatter.shared.timestampToString(
                                  timestamp: widget.message.time),
                              textColor: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                  ],
                ),
                AnimatedBuilder(
                  animation: _heartAnimationController,
                  builder: (context, child) {
                    return IconButton(
                        icon: widget.message.isLiked
                            ? Icon(Icons.favorite, size: _heartAnimation.value)
                            : Icon(Icons.favorite_border,
                                size: _heartAnimation.value),
                        iconSize: 30,
                        color: widget.message.isLiked
                            ? Colors.pink.shade300
                            : Colors.black,
                        onPressed: () {
                          _heartAnimationController.forward();
                          widget.onPressFavorite(widget.message);
                        });
                  },
                )
              ]),
        ],
      ),
    );
  }
}
