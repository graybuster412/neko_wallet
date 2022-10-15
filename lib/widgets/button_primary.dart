import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class ButtonCTStyle {
  double? width;
  double? height;
  Color buttonColor = Colors.white;
  double radius = 8;
  Color borderColor = Colors.white;
  Color titleColor = Colors.black;
  double? titleSize = 12;
  FontWeight? fontWeight;

  LinearGradient? gradient;

  ButtonCTStyle.empty() {
    buttonColor = Colors.transparent;
    titleColor = Colors.black;
  }

  ButtonCTStyle(
      {this.width,
      this.height,
      this.buttonColor = Colors.transparent,
      this.titleColor = Colors.black,
      this.borderColor = Colors.transparent,
      this.fontWeight: FontWeight.normal,
      this.radius = 8,
      this.titleSize,
      this.gradient}) {
    this.width = width;
    this.height = height;
    this.buttonColor = buttonColor;
    this.titleColor = titleColor;
    this.borderColor = borderColor;
    this.radius = radius;
  }
}

class ButtonCT extends StatelessWidget {
  const ButtonCT(
      {Key? key,
      required this.title,
      this.buttonStyle,
      this.onPressButton,
      this.isDisabled = false,
      this.icon,
      this.isLoading = false})
      : super(key: key);

  final String title;

  final Icon? icon;

  final ButtonCTStyle? buttonStyle;

  final VoidCallback? onPressButton;

  final bool isLoading;

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonStyle?.height,
      decoration: BoxDecoration(
          gradient: buttonStyle?.gradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 1.0,
              color: this.buttonStyle?.borderColor ?? Colors.transparent),
          color: buttonStyle?.buttonColor),
      child: AbsorbPointer(
        absorbing: this.isDisabled,
        child: TextButton(
          onPressed: onPressButton,
          child: Center(
            child: isLoading
                ? Container(
                    width: 17,
                    height: 17,
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.grey.shade100))
                : StyleText(
                    text: this.title,
                    fontWeight: buttonStyle?.fontWeight ?? FontWeight.normal,
                    fontSize: buttonStyle?.titleSize ?? 14,
                    textColor: buttonStyle?.titleColor),
          ),
        ),
      ),
    );
  }
}
