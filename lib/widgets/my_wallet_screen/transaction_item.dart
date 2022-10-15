import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

import '../../shared/shared.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(
      {Key? key,
      required this.transaction,
      this.hasSeparator: false,
      this.hasTopBorder: false,
      this.hasBottomBorder: false})
      : super(key: key);

  final Transaction transaction;

  final bool hasSeparator;

  final bool hasTopBorder;

  final bool hasBottomBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        color: AppColors.gray4,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(hasTopBorder ? 5.0 : 0.0),
            topRight: Radius.circular(hasTopBorder ? 5.0 : 0.0),
            bottomLeft: Radius.circular(hasBottomBorder ? 5.0 : 0.0),
            bottomRight: Radius.circular(hasBottomBorder ? 5.0 : 0.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(236, 236, 236, 0.5),
            offset: Offset(0, -1),
            blurRadius: 0.0,
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: hasSeparator
              ? Border(
                  bottom:
                      BorderSide(color: HexColor.fromHex('#F7F6F8'), width: 1))
              : null,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 34,
              width: 34,
              child: transaction.icon,
            ),
            SizedBox(width: 20.0),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleText(
                      text: transaction.title ?? '',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      textColor: HexColor.fromHex('#353333')),
                  StyleText(
                      text: transaction.content ?? '',
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      textColor: HexColor.fromHex('#AFAFAF')),
                ])
          ]),
          StyleText(
              text: transaction.amount,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              textColor: HexColor.fromHex('#EF6874'))
        ]),
      ),
    );
  }
}
