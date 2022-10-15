import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/widgets/transactions/line_chart_ct.dart';

import '../../shared/shared.dart';

class AnalyticsBalance extends StatefulWidget {
  const AnalyticsBalance({Key? key}) : super(key: key);

  @override
  _AnalyticsBalanceState createState() => _AnalyticsBalanceState();
}

class _AnalyticsBalanceState extends State<AnalyticsBalance> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Transactions",
                    style: TextStyle(
                      fontFamily: AppFonts.primary,
                      fontSize: 14,
                      color: HexColor.fromHex("#353333"),
                      fontWeight: FontWeight.w600,
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("This month",
                            style: TextStyle(
                              fontFamily: AppFonts.primary,
                              fontSize: 14,
                              color: HexColor.fromHex("#AFAFAF"),
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(width: 3),
                        SizedBox(
                            height: 18,
                            width: 18,
                            child: CommonWidget.svgImage('transaction_up')),
                      ],
                    ))
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("\$6,200.00",
                        style: TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 22,
                          color: HexColor.fromHex("#353333"),
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                        height: 24,
                        width: 24,
                        child: CommonWidget.svgImage('transaction_up')),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(child: LineChartCT()),
                SizedBox(width: 5),
              ],
            )
          ],
        ));
  }
}
