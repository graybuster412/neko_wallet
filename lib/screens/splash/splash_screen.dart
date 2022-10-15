import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/screens/splash/splash.dart';
import 'package:neko_wallet/shared/colors.dart';
import 'package:neko_wallet/shared/common_widget.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/base_screen.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useSafeArea: false,
      child: Container(
        decoration: BoxDecoration(
          gradient: makeLinearGradient(
            colors: AppColors.primaryGradientColors,
            start: Alignment(-1.0, -1),
            end: Alignment(-1.0, 1),
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: CommonWidget.pngImage('launch_logo'),
          ),
        ),
      ),
    );
  }
}
