import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'shared.dart';

class CommonWidget {
  static SizedBox rowHeight(
      {double height = CommonConstants.horizontalSpacing}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = CommonConstants.horizontalSpacing}) {
    return SizedBox(width: width);
  }

  static SizedBox smallRowHeight() {
    return SizedBox(height: 8);
  }

  static SizedBox smallRowWidth() {
    return SizedBox(width: 8);
  }

  static void toast(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void showDialog(
      {customWidget: Widget,
      Curve? transition,
      bool useSafeArea: true,
      bool barrierDismissible: true}) async {
    await Get.dialog(
      customWidget,
      transitionCurve: transition ?? Curves.bounceInOut,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
    );
  }

  static void showSnackbar(
      {required String title, required String message, int duration = 3000}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(title, message, duration: Duration(milliseconds: duration));
    }
  }

  static SvgPicture svgImage(String svg, {Color? color, Size? size}) {
    return SvgPicture.asset('assets/svgs/$svg.svg',
        color: color, height: size?.height, width: size?.width);
  }

  static Image pngImage(String path, {Size? size, BoxFit? fit}) {
    return Image.asset('assets/images/$path.png',
        fit: fit, height: size?.height, width: size?.width);
  }
}
