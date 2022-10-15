import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class OnlyTextButton extends StatelessWidget {
  final String _text;
  final Color _textColor;
  final double _fontSize;
  final FontWeight fontWeight;
  final VoidCallback? _callback;

  OnlyTextButton(
      {String text = "",
      Color textColor = Colors.white,
      this.fontWeight: FontWeight.normal,
      double fontSize = 16,
      VoidCallback? onPressed})
      : this._callback = onPressed,
        this._text = text,
        this._textColor = textColor,
        this._fontSize = fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _callback,
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyleText(
                  text: _text,
                  fontSize: _fontSize,
                  fontWeight: this.fontWeight,
                  textColor: this._textColor,
                ),
              ],
            ),
          ),
        ));
  }
}
