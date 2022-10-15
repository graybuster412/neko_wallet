import 'package:firebase_core/firebase_core.dart';
import 'package:neko_wallet/screens/auth/controllers/auth_controller.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/theme/fonts.dart';

import 'app_binding.dart';
import 'services/services.dart';

// void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync(() => StorageService().init());

  // Initialize firebase
  await Firebase.initializeApp().then((value) {
    // Initialize auth controller to global authentication
    Get.put(AuthController());
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Neko Wallet',
      debugShowCheckedModeBanner: false,
      enableLog: true,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      initialRoute: RouteManager.SPLASH,
      getPages: RouteManager.generateRoutePages(),
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      theme:
          ThemeData(primarySwatch: Colors.blue, fontFamily: AppFonts.primary),
    );
  }
}
