import 'package:get/get.dart';
import 'package:neko_wallet/models/transaction.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/transaction_item.dart';
import 'package:neko_wallet/widgets/transactions/analytics_balance.dart';

import '../../shared/shared.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen();

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final transactions = [
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
        icon: CommonWidget.svgImage('ic_ps')),
    Transaction(
        title: 'Playstation',
        amount: '-\$35',
        content: 'Playstation digital purchased',
        icon: CommonWidget.svgImage('ic_ps'))
  ];

  @override
  void initState() {
    super.initState();
  }

  _buildTransactionItem(Transaction i) {
    return TransactionItem(
      transaction: i,
      hasSeparator: transactions.indexOf(i) != transactions.length - 1,
      hasTopBorder: transactions.indexOf(i) == 0,
      hasBottomBorder: transactions.indexOf(i) == transactions.length - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useSafeArea: false,
      backgroundColor: AppColors.white2,
      child: Container(
        child: Stack(
          children: [
            ListView(
                physics: ClampingScrollPhysics(),
                padding: const EdgeInsets.only(top: 0, bottom: 24.0),
                scrollDirection: Axis.vertical,
                children: [
                  Stack(children: [
                    HeaderGradient(
                      title: 'transactions'.tr,
                      iconSize: 40,
                      height: 238,
                      isCurved: true,
                      gradient: makeLinearGradient(
                          start: Alignment(-2, 0),
                          end: Alignment(4, 3),
                          colors: AppColors.primaryGradientColors),
                      onPressRightIcon: () => Get.toNamed(RouteManager.NOTIFICATION),
                      padding: EdgeInsets.only(
                        left: 22.0,
                        top: MediaQuery.of(context).padding.top + 19,
                        right: 20,
                      ),
                      rightIcon: CommonWidget.svgImage('icon_noti'),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        padding: new EdgeInsets.only(
                          top: 238 / 1.5,
                        ),
                        child: AnalyticsBalance()),
                  ]),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: transactions.length,
                        itemBuilder: (context, int index) =>
                            _buildTransactionItem(transactions[index])),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
