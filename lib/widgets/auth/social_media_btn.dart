import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class SocialMediaBtn extends StatelessWidget {
  const SocialMediaBtn(
      {Key? key,
      this.onPress,
      this.icon,
      required this.textBtn,
      this.textColor,
      this.iconSize: 24,
      this.iconColor,
      this.isLoading: false,
      this.btnColor})
      : super(key: key);

  final VoidCallback? onPress;

  final IconData? icon;

  final String textBtn;

  final bool isLoading;

  final Color? textColor;

  final Color? iconColor;

  final Color? btnColor;

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: btnColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: !isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      FaIcon(
                        icon,
                        size: iconSize,
                        color: iconColor,
                      ),
                      SizedBox(width: 10),
                      StyleText(
                        text: textBtn,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: textColor,
                      ),
                    ])
              : Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 17,
                          height: 17,
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.grey.shade100)),
                    ],
                  ),
              ),
        ),
      ),
    );
  }
}
