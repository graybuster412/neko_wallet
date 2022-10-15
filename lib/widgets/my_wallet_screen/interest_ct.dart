import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/widgets/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class InterestCT extends StatelessWidget {
  const InterestCT(
      {Key? key,
      this.containerWidth,
      required this.content,
      required this.title,
      this.progress: 0.0,
      this.progressColor})
      : super(key: key);

  final double? containerWidth;

  final String title;

  final String content;

  final double progress;

  final LinearGradient? progressColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          StyleText(
            text: title,
            textColor: HexColor.fromHex('#696565'),
            fontSize: 13,
          ),
          SizedBox(height: 5.0),
          StyleText(
              text: content,
              textColor: HexColor.fromHex('#353333'),
              fontSize: 20,
              fontWeight: FontWeight.w600),
          SizedBox(height: 5.0),
          ProgressView(
            size: Size((containerWidth ?? 0) - 60, 4),
            propress: progress,
            progressColor: progressColor,
          )
        ],
      ),
    );
  }
}
