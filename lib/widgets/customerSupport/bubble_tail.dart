import 'package:flutter/material.dart';

enum BubbleDirection { left, right }

class BubbleTail extends CustomPainter {
  BubbleTail({required this.bubbleColor});

  final Color bubbleColor;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bubbleColor;

    var path = Path();
    path.lineTo(15, 0);
    path.lineTo(0, -14);
    path.lineTo(-12, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
