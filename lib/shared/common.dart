import 'package:flutter/material.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/utils.dart';

class CommonConstants {
  static const String test = 'test';
  static const num testNum = 1;
  static const totalOnboardingStep = 4;
  static const double horizontalSpacing = 30;
  static const double text40 = 40.0;
  static const double text26 = 26.0;
  static const double text22 = 22.0;
  static const double text24 = 24.0;
  static const double text18 = 18.0;
  static const double text16 = 16.0;
  static const double text14 = 14.0;
  static const double text12 = 12.0;
  static const double text10 = 10.0;
  static const double text8 = 8.0;
  static const double text20 = 20.0;

  static final Shader textLinearGradient =
      makeLinearGradient(colors: AppColors.primaryGradientColors)
          .createShader(Rect.fromLTWH(0.0, 50.0, 150.0, 100.0));

  static final LinearGradient primaryGradient = LinearGradient(
      begin: Alignment(-1.0, -1),
      end: Alignment(-1.0, 1),
      colors: AppColors.primaryGradientColors,
      tileMode: TileMode.clamp);
}
