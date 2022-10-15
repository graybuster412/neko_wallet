import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/services/services.dart';

import '../../../shared/shared.dart';

class AppController extends GetxController {
  AppController();

  Rx<User?> _firebaseUser = Rx(null);

  @override
  void onReady() {
    super.onReady();

    _firebaseUser = Rx<User?>(FirebaseManager.shared.auth.currentUser);

    _firebaseUser.bindStream(FirebaseManager.shared.auth.userChanges());

    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // A workaround for facebook email is not trustworthy email
      if (user.providerData.first.providerId == 'facebook.com' &&
          !user.emailVerified) {
        // Send email verification for user
        user.sendEmailVerification();

        // Signout current user
        GoogleAuthService.shared.logout();
        FacebookAuthService.shared.logout();
        FirebaseManager.shared.signOut();

        // Then make user to verify the email
        CommonWidget.showSnackbar(
            title: 'email_verification'.tr,
            message: "verification_link_sent"
                .trParams({"email": user.email ?? "email"}));

        Future.delayed(Duration(milliseconds: 501), () {
          if (Get.currentRoute != RouteManager.LOGIN_SCREEN) {
            Get.offAllNamed(RouteManager.LOGIN_SCREEN);
          }
        });
        return;
      }

      if (user.emailVerified) {
        Get.offAllNamed(RouteManager.HOME_TRANSACTON);
      } else {
        // Send email verification
        FirebaseManager.shared.sendEmailVerification();

        // Signout current user
        GoogleAuthService.shared.logout();
        FacebookAuthService.shared.logout();
        FirebaseManager.shared.signOut();

        // Case not verified navigate to welcome screen
        if (Get.currentRoute != RouteManager.LOGIN_SCREEN) {
          if (Get.currentRoute == RouteManager.REGISTER_SCREEN) {
            Get.offAllNamed(
                RouteManager.LOGIN_SCREEN +
                    RouteManager.SPLASH +
                    RouteManager.LOGIN_SCREEN,
                arguments: user.email);
          } else {
            Get.offAllNamed(RouteManager.WELCOME_SCREEN);
          }
        } else if (Get.currentRoute == RouteManager.REGISTER_SCREEN) {
          Get.offAllNamed(
              RouteManager.LOGIN_SCREEN +
                  RouteManager.SPLASH +
                  RouteManager.LOGIN_SCREEN,
              arguments: user.email);
        }

        Future.delayed(Duration(milliseconds: 1000), () {
          // Delay 1s to display snackbar message
          CommonWidget.showSnackbar(
              title: 'email_verification'.tr,
              message: "verification_link_sent"
                  .trParams({"email": user.email ?? "email"}));
        });
      }
    } else {
      Get.offAllNamed(RouteManager.WELCOME_SCREEN);
    }
  }
}
