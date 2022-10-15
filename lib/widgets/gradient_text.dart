import 'package:flutter/material.dart';

class GradientText extends StatefulWidget {
  GradientText({Key? key, required this.text, required this.colors})
      : super(key: key);

  final List<Color> colors;

  final String text;

  @override
  _GradientTextState createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText> {
  @override
  Widget build(BuildContext context) {
    final Shader textLinearGradient = LinearGradient(
      colors: <Color>[widget.colors[0], widget.colors[1]],
    ).createShader(Rect.fromLTWH(0.0, 50.0, 150.0, 100.0));
    return Text(widget.text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            foreground: Paint()..shader = textLinearGradient));
  }
}
