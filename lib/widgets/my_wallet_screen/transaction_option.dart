import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/add_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionOption extends StatelessWidget {
  const TransactionOption({Key? key, this.onPressButton}) : super(key: key);

  final ValueChanged<TransactionType>? onPressButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AddNew(
            title: 'New income',
            onPressButton: () => onPressButton!(TransactionType.income),
            icon: CommonWidget.svgImage('ic_new_income'),
            style: BoxDecoration(
              color: AppColors.gray4,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
          ),
          AddNew(
            title: 'New expense',
            icon: CommonWidget.svgImage('ic_new_expense'),
            hasSeparator: true,
            onPressButton: () => onPressButton!(TransactionType.income),
            style: BoxDecoration(
                color: AppColors.gray4,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )),
          ),
        ],
      ),
    );
  }
}
