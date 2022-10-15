import 'package:get/get.dart';
import 'package:neko_wallet/screens/home/home_screen.dart';
import 'package:neko_wallet/screens/notifications/notification_screen.dart';
import 'package:neko_wallet/screens/profile/credit_card_screen.dart';
import 'package:neko_wallet/screens/profile/edit_profile_screen.dart';
import 'package:neko_wallet/screens/support/chat_screen.dart';
import 'package:neko_wallet/screens/support/customer_support_screen.dart';

import 'package:flutter/material.dart';

import '../screens/auth/auth.dart';
import '../screens/home/dash_board.dart';
import '../screens/splash/splash.dart';

class RouteManager {
  static const HOME_SUPPORT_SCREEN = "/HOME_SUPPORT";

  static const WELCOME_SCREEN = "/WELCOME";

  static const REGISTER_SCREEN = "/REGISTER";

  static const FORGOT_PASSWORD_SCREEN = "/FORGOT_PASSWORD";

  static const LOGIN_SCREEN = "/LOGIN";

  static const SPLASH = "/";

  static const HOME_TRANSACTON = "/HOME_TRANSACTON";

  static const EDIT_PROFILE = "/EDIT_PROFILE";

  static const PROFILE = "/PROFILE";

  static const MY_WALLET = "/MY_WALLET";

  static const TRANSACTION = "/TRANSACTION";

  static const CREDIT_CARD = "/CREDIT_CARD";

  static const NOTIFICATION = "/NOTIFICATION";

  static const VERIFICATION = "/VERIFICATION";

  static const RESET_PASSWORD = "/RESET_PASSWORD";

  static const CHAT = "/CHAT";

  static Route _createRoute(Widget widget) {
    // return PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) => wiget,
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     var begin = Offset(0.0, 1.0);
    //     var end = Offset.zero;
    //     var curve = Curves.ease;

    //     var tween =
    //         Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    //     return SlideTransition(
    //       position: animation.drive(tween),
    //       child: child,
    //     );
    //   },
    // );
    return MaterialPageRoute(builder: (_) => widget);
  }

  static List<GetPage> generateRoutePages() {
    return [
      GetPage(
          name: SPLASH, page: () => SplashScreen(), binding: SplashBinding()),
      GetPage(name: HOME_SUPPORT_SCREEN, page: () => CustomerSupportScreen()),
      GetPage(name: WELCOME_SCREEN, page: () => WelcomeScreen()),
      GetPage(
          name: REGISTER_SCREEN,
          binding: RegisterBinding(),
          page: () => RegisterScreen()),
      GetPage(
          name: FORGOT_PASSWORD_SCREEN,
          binding: ForgotPasswordBinding(),
          page: () => ForgetPasswordScreen()),
      GetPage(
          name: LOGIN_SCREEN,
          page: () => LoginScreen(),
          binding: LoginBinding()),
      GetPage(
          name: VERIFICATION,
          binding: VerificationBinding(),
          page: () => VerificationScreen()),
      GetPage(
          name: RESET_PASSWORD,
          binding: ResetPasswordBinding(),
          page: () => ResetPasswordScreen()),
      GetPage(
          name: HOME_TRANSACTON,
          binding: DashBoardBinding(),
          page: () => HomeScreen()),
      GetPage(name: NOTIFICATION, page: () => NotificationScreen()),
      GetPage(name: CHAT, page: () => ChatScreen()),
    ];
  }

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WELCOME_SCREEN:
        return _createRoute(WelcomeScreen());
      case REGISTER_SCREEN:
        return _createRoute(RegisterScreen());
      case LOGIN_SCREEN:
        return _createRoute(LoginScreen());
      case FORGOT_PASSWORD_SCREEN:
        return _createRoute(ForgetPasswordScreen());
      case HOME_SUPPORT_SCREEN:
        return _createRoute(CustomerSupportScreen());
      case HOME_TRANSACTON:
        return _createRoute(HomeScreen());
      case EDIT_PROFILE:
        // UserModel user = routeSettings.arguments as UserModel;
        return _createRoute(EditProfileScreen());
      case CREDIT_CARD:
        return _createRoute(CreditCardScreen());
      case NOTIFICATION:
        return _createRoute(NotificationScreen());
      case VERIFICATION:
        return _createRoute(VerificationScreen());
      default:
        return _createRoute(WelcomeScreen());
    }
  }
}
