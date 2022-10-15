import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/shared/common.dart';
import 'package:neko_wallet/widgets/style_text.dart';
import '../models/models.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StyleText(
                text: 'favourite_chats'.tr,
                textColor: Colors.blueGrey,
                fontSize: CommonConstants.text18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30.0,
                  onPressed: () {})
            ],
          ),
        ),
        Container(
          height: 120.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10.0),
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Get.toNamed(RouteManager.CHAT,
                      arguments: favorites[index]),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      favorites[index].imageUrl != null
                          ? CircleAvatar(
                              radius: 35.0,
                              backgroundImage:
                                  AssetImage(favorites[index].imageUrl!),
                            )
                          : Container(),
                      SizedBox(height: 6.0),
                      StyleText(
                          text: favorites[index].name ?? "",
                          textColor: Colors.blueGrey,
                          fontSize: CommonConstants.text16,
                          fontWeight: FontWeight.w600)
                    ]),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
