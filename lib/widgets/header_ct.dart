import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_wallet/widgets/style_text.dart';

import '../shared/shared.dart';

class HeaderCT extends StatelessWidget {
  final double? height;

  final String title;

  final SvgPicture? leftIcon;

  final SvgPicture? rightIcon;

  final double iconSize;

  final VoidCallback? onPressIcon;

  final TextStyle? titleStyle;

  const HeaderCT(
      {Key? key,
      this.height,
      required this.title,
      this.iconSize: 24,
      this.leftIcon,
      this.titleStyle,
      this.onPressIcon,
      this.rightIcon: null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: leftIcon != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisAlignment: leftIcon != null
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        leftIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: InkWell(
                  onTap: onPressIcon,
                  child: SizedBox(
                    height: iconSize,
                    width: iconSize,
                    child: leftIcon,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: StyleText(
            text: title,
            fontWeight: titleStyle?.fontWeight ?? FontWeight.bold,
            fontSize: titleStyle?.fontSize ?? CommonConstants.text24,
            textColor: titleStyle?.color ?? Colors.white,
          ),
        ),
        rightIcon != null
            ? Material(
                child: InkResponse(
                  containedInkWell: true,
                  focusColor: Color.fromRGBO(0, 0, 0, 0.5),
                  onTap: onPressIcon ?? () {},
                  child: SizedBox(
                    height: iconSize,
                    width: iconSize,
                    child: rightIcon,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
