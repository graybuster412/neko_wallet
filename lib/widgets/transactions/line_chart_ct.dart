import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/extensions/hex_color.dart';

import '../../shared/shared.dart';

class LineChartCT extends StatefulWidget {
  @override
  _LineChartCTState createState() => _LineChartCTState();
}

class _LineChartCTState extends State<LineChartCT> {
  List<Color> gradientColors = [
    HexColor.fromHex("#9D61F7"),
    HexColor.fromHex("#80F0FF"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: LineChart(
        mainData(),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => TextStyle(
              color: HexColor.fromHex("#353333"),
              fontFamily: AppFonts.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return '';
          },
          margin: 5,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => TextStyle(
            color: HexColor.fromHex("#353333"),
            fontFamily: AppFonts.primary,
            fontSize: 15,
          ),
          getTitles: (value) {
            return '';
          },
          reservedSize: 28,
          margin: 22,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 0)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 0,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color).toList(),
          ),
        ),
      ],
    );
  }
}
