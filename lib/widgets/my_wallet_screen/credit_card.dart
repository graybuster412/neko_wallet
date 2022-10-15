import 'package:get/get.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/credit_card_view_model.dart';
import 'package:neko_wallet/shared/colors.dart';
import 'package:neko_wallet/widgets/currency.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class CreditCard extends StatelessWidget {
  final Size size;

  final Color? creditCardTypeColor;

  final List<Color> currencyColors;

  final Border? currencyBorderStyle;

  final Color? backgroundColor;

  final CreditCardViewModel creditCardModel;

  final List<BoxShadow> shadows;

  final LinearGradient? gradient;

  final Widget? visaIcon;

  final EdgeInsets? margin;

  final bool useWhiteTextColor;

  const CreditCard(
      {Key? key,
      this.size: const Size(315, 173),
      this.creditCardTypeColor,
      this.currencyColors: const [],
      this.currencyBorderStyle,
      this.backgroundColor: Colors.white,
      this.gradient,
      this.visaIcon,
      this.useWhiteTextColor: false,
      this.margin,
      this.shadows: const [
        BoxShadow(
          color: Color.fromRGBO(26, 41, 41, 0.15),
          blurRadius: 40,
          offset: Offset(0, 10),
        ),
      ],
      required this.creditCardModel})
      : super(key: key);

  bool isGradient() {
    return currencyColors.length > 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      margin: this.margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: shadows,
          gradient: this.gradient,
          color: this.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 15.0, top: 15.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Stack(
                  children: [
                    StyleText(
                        text: 'current_balance'.tr,
                        fontSize: 14,
                        textColor: this.useWhiteTextColor
                            ? Colors.white
                            : HexColor.fromHex('#6D9799')),
                    Positioned(
                      right: 8,
                      child:
                          SizedBox(height: 20, width: 50, child: this.visaIcon),
                    )
                  ],
                ),
              ),
            ]),
            SizedBox(height: 11.0),
            Row(children: [
              CurrencyCT(
                currency: creditCardModel.currencyType.toUpperCase(),
                backgroundColors: currencyColors,
                isFilledGradient: isGradient(),
                borderStyle: currencyBorderStyle,
              ),
              SizedBox(width: 11),
              StyleText(
                  text: creditCardModel.formattedCurrency(),
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  textColor:
                      this.useWhiteTextColor ? Colors.white : AppColors.text)
            ]),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.topLeft,
              child: StyleText(
                  text: creditCardModel.formattedCardNumber(),
                  textScaleFactor: 0.9,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  textColor:
                      this.useWhiteTextColor ? Colors.white : AppColors.text),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyleText(
                        text: creditCardModel.cardHolder,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: this.useWhiteTextColor
                            ? Colors.white
                            : AppColors.text),
                    StyleText(
                        text: creditCardModel.formattedExpiredDate('MM/yy'),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: this.useWhiteTextColor
                            ? Colors.white
                            : AppColors.text),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
