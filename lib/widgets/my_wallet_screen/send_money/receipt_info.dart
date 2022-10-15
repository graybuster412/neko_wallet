import 'package:flutter/material.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class ReceiptInfo extends StatelessWidget {
  const ReceiptInfo(
      {Key? key,
      this.title,
      this.detail,
      this.textStyle,
      this.detailValue,
      this.detailStyle})
      : super(key: key);

  final String? title;

  final String? detail;

  final String? detailValue;

  final TextStyle? textStyle;

  final TextStyle? detailStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleText(
            text: title ?? '',
            fontWeight: FontWeight.normal,
            fontSize: 14,
            textColor: HexColor.fromHex('#AFAFAF'),
          ),
          SizedBox(height: 7),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            StyleText(
              text: detail ?? '',
              fontWeight: textStyle?.fontWeight ?? FontWeight.normal,
              fontSize: textStyle?.fontSize ?? 14,
              textColor: textStyle?.color ?? HexColor.fromHex('#AFAFAF'),
            ),
            StyleText(
              text: detailValue ?? '',
              fontWeight: detailStyle?.fontWeight ?? FontWeight.normal,
              fontSize: detailStyle?.fontSize ?? 14,
              textColor: detailStyle?.color ?? HexColor.fromHex('#AFAFAF'),
            )
          ]),
        ],
      ),
    );
  }
}
