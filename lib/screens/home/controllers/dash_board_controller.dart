import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/screens/home/dash_board.dart';
import 'package:neko_wallet/widgets/add_transaction_popup.dart';

import '../../../utils/utils.dart';
import '../../profile/profile_screen.dart';
import '../../transactions/transactions_screen.dart';

class DashBoardController extends GetxController {
  final currentIndex = 0.obs;

  List<Widget> bottomTabItems = [];

  final HomePageController myController = HomePageController();

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  Widget get bottomTabItem {
    return bottomTabItems[currentIndex.value];
  }

  Future<void> onPressAdd() async {
    return showPopup(Get.context, AddTransactionPopup());
  }

  String getIcon(int index) {
    switch (index) {
      case 0:
        return currentIndex.value == index
            ? 'icon_wallet_active'
            : 'icon_wallet_inactive';
      case 1:
        return currentIndex.value == index
            ? 'ic_analytics_active'
            : 'ic_analytics_inactive';
      case 2:
        return currentIndex.value == index
            ? 'ic_saving_active'
            : 'ic_saving_inactive';
      case 3:
        return currentIndex.value == index
            ? 'ic_profile_active'
            : 'ic_profile_inactive';
      default:
        return '';
    }
  }

  onTapped(int selectedIndex) {
    if (currentIndex.value == selectedIndex) {
      switch (selectedIndex) {
        case 0:
          firstTabNavKey.currentState?.popUntil((r) => r.isFirst);
          break;
        case 1:
          secondTabNavKey.currentState?.popUntil((r) => r.isFirst);
          break;
        case 2:
          thirdTabNavKey.currentState?.popUntil((r) => r.isFirst);
          break;
      }
    }
    currentIndex.value = selectedIndex;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    bottomTabItems = [
      MyWalletScreen(),
      TransactionsScreen(),
      MyWalletScreen(),
      ProfileScreen(),
    ];

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
