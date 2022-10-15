import 'dart:math';

import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;

export 'focus.dart';

String formatDateWith(date, String format) {
  if (date is DateTime) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(date);
  } else if (date is String) {
    final DateTime convertedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat(format);
    return formatter.format(convertedDate);
  }
  return '';
}

String? formatCurrency({String? currency, String currencyType: "en_US"}) {
  final oCcy = new NumberFormat("#,##0.00", currencyType);
  return currency != null ? '\$' + oCcy.format(double.parse(currency)) : null;
}

LinearGradient makeLinearGradient(
    {Alignment start: Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
    List<double> stops: const [0.0, 0.6],
    List<Color> colors: const [
      const Color.fromRGBO(157, 235, 147, 1),
      const Color.fromRGBO(23, 183, 189, 1)
    ],
    TileMode mode: TileMode.clamp}) {
  return LinearGradient(
      begin: start,
      end: end,
      stops: stops,
      colors: colors,
      tileMode: TileMode.clamp);
}

List<Color> creditCardGradientColor() {
  final rn = new Random();

  final int rnNumber = 1 + rn.nextInt(5 - 1);

  switch (rnNumber) {
    case 1:
      return [HexColor.fromHex("#34FFF6"), HexColor.fromHex("#23429D")];
    case 2:
      return [HexColor.fromHex("#C69CFF"), HexColor.fromHex("#6112D8")];
    case 3:
      return [HexColor.fromHex("#FFC996"), HexColor.fromHex("#E73E79")];
    case 4:
      return [HexColor.fromHex("#9D61F7"), HexColor.fromHex("#80F0FF")];
    default:
      return [HexColor.fromHex("#34FFF6"), HexColor.fromHex("#23429D")];
  }
}

bool isAndroid() => Platform.isAndroid;

Future<void> showPopup(context, Widget widget) {
  return showDialog<void>(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) => GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: widget,
      ),
    ),
  );
}
