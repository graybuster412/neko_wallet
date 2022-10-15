import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class AddNew extends StatelessWidget {
  const AddNew(
      {Key? key,
      this.icon,
      required this.title,
      this.onPressButton,
      this.style,
      this.hasSeparator: false})
      : super(key: key);

  final String title;

  final VoidCallback? onPressButton;

  final BoxDecoration? style;

  final bool hasSeparator;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressButton,
      child: Container(
        decoration: style,
        height: 114,
        width: MediaQuery.of(context).size.width / 2 - 20,
        child: Container(
          decoration: BoxDecoration(
              border: this.hasSeparator
                  ? Border(
                      left: BorderSide(
                          color: HexColor.fromHex('#F1F1F1'), width: 1))
                  : null),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(child: icon, width: 42, height: 42),
              StyleText(
                text: title,
                fontSize: 13,
                textColor: HexColor.fromHex('#696565'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
