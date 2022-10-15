import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class HeaderGradient extends StatelessWidget {
  final double? height;

  final String title;

  final SvgPicture? leftIcon;

  final SvgPicture? rightIcon;

  final double iconSize;

  final Function? onPressRightIcon;

  final Function? onPressLeftIcon;

  final FontWeight? fontWeight;

  final double fontSize;

  final Color textColor;

  final bool isCurved;

  final LinearGradient? gradient;

  final EdgeInsets? padding;

  const HeaderGradient(
      {Key? key,
      this.height,
      required this.title,
      this.fontSize: 24,
      this.fontWeight: FontWeight.bold,
      this.textColor: Colors.white,
      this.iconSize: 24,
      this.leftIcon: null,
      this.isCurved: false,
      this.onPressRightIcon,
      this.onPressLeftIcon,
      this.padding,
      this.gradient: null,
      this.rightIcon: null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            bottom:
                isCurved ? Radius.elliptical(screenWidth, 140.0) : Radius.zero),
        gradient: this.gradient,
      ),
      width: MediaQuery.of(context).size.width,
      padding: padding,
      height: height ?? 114,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isCurved
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            leftIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkResponse(
                        radius: 16,
                        containedInkWell: true,
                        focusColor: Color.fromRGBO(0, 0, 0, 0.5),
                        onTap: () => onPressLeftIcon,
                        child: SizedBox(
                          height: iconSize,
                          width: iconSize,
                          child: leftIcon,
                        ),
                      ),
                    ),
                  )
                : Container(),
            StyleText(
              text: title,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              textColor: Colors.white,
            ),
            Spacer(),
            rightIcon != null
                ? Material(
                    color: Colors.transparent,
                    child: InkResponse(
                      radius: 16,
                      containedInkWell: true,
                      focusColor: Color.fromRGBO(0, 0, 0, 0.5),
                      onTap: () => onPressRightIcon,
                      child: SizedBox(
                        height: iconSize,
                        width: iconSize,
                        child: rightIcon,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
