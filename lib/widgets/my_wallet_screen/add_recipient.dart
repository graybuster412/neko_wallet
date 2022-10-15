import 'package:get/get.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class AddRecipient extends StatelessWidget {
  const AddRecipient({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyleText(
              text: 'send_money_to'.tr,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              textColor: HexColor.fromHex('#353333'),
            ),
            Material(
              color: Colors.transparent,
              type: MaterialType.transparency,
              child: InkResponse(
                containedInkWell: true,
                onTap: onPress,
                child: Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(24 / 2)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1],
                              colors: [
                                HexColor.fromHex('#9DEB93'),
                                AppColors.blue1
                              ],
                              tileMode: TileMode.clamp)),
                      child: Icon(Icons.add_rounded,
                          size: 20, color: Colors.white),
                    ),
                    SizedBox(width: 11),
                    StyleText(
                      text: 'add_recipient'.tr,
                      textColor: AppColors.blue1,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
