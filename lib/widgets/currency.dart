import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

import '../shared/shared.dart';

class CurrencyCT extends StatelessWidget {
  const CurrencyCT(
      {Key? key,
      required this.currency,
      this.isFilledGradient: false,
      this.backgroundColors: const [],
      this.borderStyle})
      : super(key: key);

  final String currency;

  final bool isFilledGradient;

  final List<Color> backgroundColors;

  final Border? borderStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 40,
        decoration: BoxDecoration(
            gradient: isFilledGradient
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1],
                    colors: backgroundColors,
                    tileMode: TileMode.clamp)
                : null,
            border: borderStyle,
            color: isFilledGradient ? null : backgroundColors[0],
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Center(
          child: StyleText(
            text: currency,
            textColor: Colors.white,
            fontSize: CommonConstants.text14,
          ),
        ));
  }
}
