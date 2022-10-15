import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/utils/date_time_formatter.dart';
import 'package:neko_wallet/widgets/style_text.dart';
import '../models/message_model.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                final Message chat = chats[index];
                return GestureDetector(
                  onTap: () =>
                      Get.toNamed(RouteManager.CHAT, arguments: chat.sender),
                  child: Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: chat.unread ? Color(0xFFFFEFFE) : Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        chat.sender.imageUrl != null
                            ? Column(
                                children: [
                                  CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage:
                                          AssetImage(chat.sender.imageUrl!)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              )
                            : Container(),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              StyleText(
                                text: chat.sender.name ?? "",
                                textColor: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: StyleText(
                                  text: chat.text ?? "",
                                  textColor: Colors.blueGrey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            StyleText(
                              text: DateTimeFormatter.shared
                                  .timestampToString(timestamp: chat.time),
                              textColor: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5.0),
                            chat.unread
                                ? Container(
                                    width: 40.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: StyleText(
                                      text: 'new'.tr.toUpperCase(),
                                      textColor: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
