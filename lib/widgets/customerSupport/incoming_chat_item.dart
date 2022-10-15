import 'package:flutter/material.dart';
import 'package:neko_wallet/models/message_model.dart';
import 'package:neko_wallet/utils/date_time_formatter.dart';
import 'package:neko_wallet/widgets/customerSupport/bubble_tail.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class IncomingChatItem extends StatelessWidget {
  const IncomingChatItem(
      {Key? key, required this.message, required this.animation})
      : super(key: key);

  final Message message;

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.cyan.shade300,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
              padding:
                  EdgeInsets.only(left: 12.0, right: 22, top: 12.0, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StyleText(
                    text: message.text ?? "",
                    textAlign: TextAlign.right,
                    textColor: Colors.white,
                    fontSize: 15.0,
                  ),
                  SizedBox(height: 3.0),
                  StyleText(
                      text: DateTimeFormatter.shared
                          .timestampToString(timestamp: message.time),
                      textColor: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal),
                ],
              ),
            ),
            Positioned(
                right: 8,
                bottom: 12,
                child: CustomPaint(
                  painter: BubbleTail(bubbleColor: Colors.cyan.shade300),
                )),
          ]),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
