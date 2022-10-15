import 'package:flutter/material.dart';
import 'package:neko_wallet/shared/common_widget.dart';
import '../extensions/hex_color.dart';

class CustomBackButton extends StatefulWidget {
  CustomBackButton({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  _CustomBackButtonState createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: widget.onPress,
        child: CommonWidget.svgImage('back-icon',
            color: HexColor.fromHex('#A1AAA8')),
      ),
    );
  }
}
