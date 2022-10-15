import 'package:flutter/material.dart';

import '../shared/shared.dart';

class StyleText extends StatelessWidget {
  final String _text;
  final Color? _textColor;
  final double _fontSize;
  final FontWeight _fontWeight;
  final String? _fontFamily;
  final TextAlign _textAlign;
  final TextOverflow overflow;
  final Shader? textLinearGradient;
  final int? lines;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final double textScaleFactor;

  StyleText(
      {String text = "",
      Color? textColor,
      double fontSize = 16,
      TextAlign textAlign = TextAlign.left,
      TextOverflow overflow = TextOverflow.ellipsis,
      int? lines = 2,
      this.letterSpacing,
      this.textLinearGradient,
      this.textScaleFactor: 1,
      this.decoration,
      String? fontFamily = AppFonts.primary,
      FontWeight fontWeight = FontWeight.normal})
      : this._text = text,
        this._textColor = textColor,
        this._fontSize = fontSize,
        this._textAlign = textAlign,
        this.overflow = overflow,
        this.lines = lines,
        this._fontFamily = fontFamily,
        this._fontWeight = fontWeight;

  @override
  Widget build(BuildContext context) {
    return textLinearGradient != null
        ? Text(_text,
            maxLines: lines,
            textAlign: _textAlign,
            textScaleFactor: textScaleFactor,
            overflow: overflow,
            style: TextStyle(
              fontSize: _fontSize,
              letterSpacing: letterSpacing,
              fontWeight: this._fontWeight,
              fontFamily: _fontFamily,
              foreground: Paint()..shader = textLinearGradient,
            ))
        : Text(_text,
            maxLines: lines,
            textAlign: _textAlign,
            textScaleFactor: textScaleFactor,
            overflow: overflow,
            style: TextStyle(
              fontSize: _fontSize,
              color: this._textColor ?? AppColors.text,
              letterSpacing: letterSpacing,
              fontWeight: this._fontWeight,
              fontFamily: _fontFamily,
              decoration: decoration,
              decorationColor: _textColor,
              decorationThickness:
                  decoration == TextDecoration.underline ? 1 : null,
            ));
  }
}
