import 'package:flutter/material.dart';

class AppColors {
  static Color primary = hexToColor('#9DEB93');
  static Color blue1 = hexToColor('#17B7BD');
  static Color text = hexToColor('#353333');
  static Color gray1 = hexToColor('#AFAFAF');
  static Color gray2 = hexToColor('#696565');
  static Color gray3 = hexToColor('#C4C2CB');
  static Color gray4 = hexToColor("#FEFEFE");
  static Color white1 = hexToColor('#F0FFFB');
  static Color white2 = hexToColor('#F2F2F2');
  static Color seperator = hexToColor('#F6F6F6');
  static const Color white = Colors.white;
  static Color transparent = Colors.transparent;

  static Color red1 = hexToColor('#DB4437');
  static Color facebook = hexToColor('#4267B2');
  static Color blue2 = hexToColor('#098ADE');

  static final List<Color> primaryGradientColors = [
    const Color.fromRGBO(118, 201, 216, 1),
    const Color.fromRGBO(121, 183, 223, 1)
  ];
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
