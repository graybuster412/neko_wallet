import 'package:get/get.dart';
import 'package:neko_wallet/models/transaction.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/transaction_item.dart';
import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class CartLatestTransaction extends StatefulWidget {
  CartLatestTransaction({Key? key, this.onChangedTab}) : super(key: key);

  final ValueChanged<int>? onChangedTab;

  @override
  _CartLatestTransactionState createState() => _CartLatestTransactionState();
}

class _CartLatestTransactionState extends State<CartLatestTransaction> {
  final _currentSelectedIndex = 0.obs;

  final tabBars = ['all'.tr, 'received'.tr, 'send'.tr];

  final latestTransactions = [
    Transaction(
        title: 'Dripple',
        amount: '-\$25',
        content: 'Pro account subscription',
        icon: CommonWidget.svgImage('dribbble')),
    Transaction(
        title: 'Sketch App',
        amount: '-\$125',
        content: 'License Update',
        icon: CommonWidget.svgImage('ic_ps')),
    Transaction(
        title: 'Playstation',
        amount: '-\$35',
        content: 'Playstation digital purchased',
        icon: CommonWidget.svgImage('ic_ps'))
  ];

  onSelectedTab(int selectedIndex) {
    _currentSelectedIndex.value = selectedIndex;

    widget.onChangedTab!(selectedIndex);
  }

  onPressSeeMore() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
                children: List.generate(tabBars.length, (int index) {
              return TextButton(
                onPressed: () {
                  onSelectedTab(index);
                },
                child: Opacity(
                  opacity: _currentSelectedIndex == index ? 1.0 : 0.5,
                  child: Obx(
                    () => StyleText(
                      text: tabBars[index],
                      textColor: _currentSelectedIndex == index
                          ? AppColors.text
                          : AppColors.gray2,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            })),
            IconButton(
              splashColor: Colors.black.withOpacity(0.5),
              color: Colors.transparent,
              onPressed: onPressSeeMore,
              padding: EdgeInsets.only(left: 21.0),
              icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: CommonWidget.svgImage('ic_see_more')),
            ),
          ]),
          for (var i in latestTransactions)
            TransactionItem(
              transaction: i,
              hasSeparator: latestTransactions.indexOf(i) !=
                  latestTransactions.length - 1,
              hasTopBorder: latestTransactions.indexOf(i) == 0,
              hasBottomBorder: latestTransactions.indexOf(i) ==
                  latestTransactions.length - 1,
            )
        ],
      ),
    );
  }
}
