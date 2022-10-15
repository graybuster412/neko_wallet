import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/shared/shared.dart';
import '../../widgets/category_selector.dart';
import '../../widgets/favorite_contacts.dart';
import '../../widgets/recent_chats.dart';

class HomeSupportScreen extends StatefulWidget {
  @override
  _HomeSupportScreenState createState() => _HomeSupportScreenState();
}

class _HomeSupportScreenState extends State<HomeSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {}),
        title: StyleText(
            text: 'customer_support'.tr,
            fontSize: 28.0,
            fontWeight: FontWeight.bold),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {})
        ],
      ),
      child: Column(children: <Widget>[
        CategorySelector(),
        Expanded(
          child: Container(
            height: 500.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(
              children: <Widget>[
                FavoriteContacts(),
                RecentChats(),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
