import 'package:get/get.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/services/services.dart';

import '../../../shared/shared.dart';

class SplashController extends GetxController {
  SplashController();
  @override
  void onReady() async {
    super.onReady();

    try {
      final isAuthenticated =
          await StorageService.getBool(key: StorageConstants.isAuthenticated);
      if (isAuthenticated) {
        Get.offAllNamed(RouteManager.HOME_TRANSACTON);
      } else {
        Get.offAllNamed(RouteManager.WELCOME_SCREEN);
      }
    } catch (e) {
      Get.offAllNamed(RouteManager.WELCOME_SCREEN);
    }
  }
}
