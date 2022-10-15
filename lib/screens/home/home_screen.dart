import 'package:get/get.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/tab_bar_ct.dart';
import 'package:flutter/material.dart';

import 'dash_board.dart';
class HomeScreen extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomTabBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
        height: 88,
        iconSize: 52,
        onTabSelected: controller.onTapped,
        items: [
          CustomBottomTabBarItem(iconData: CommonWidget.svgImage(controller.getIcon(0))),
          CustomBottomTabBarItem(iconData: CommonWidget.svgImage(controller.getIcon(1))),
          CustomBottomTabBarItem(iconData: CommonWidget.svgImage(controller.getIcon(2))),
          CustomBottomTabBarItem(iconData: CommonWidget.svgImage(controller.getIcon(3))),
        ],
      ),
      body: Obx(() => controller.bottomTabItem),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(52 / 2)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1],
                colors: [AppColors.primary, AppColors.blue1],
                tileMode: TileMode.clamp)),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: controller.onPressAdd,
          elevation: 0,
          child: Icon(Icons.add_rounded, size: 40, color: Colors.white),
        ),
      ),
    );
  }
}
