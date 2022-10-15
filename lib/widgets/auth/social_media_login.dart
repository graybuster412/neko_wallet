import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/widgets/auth/social_media_btn.dart';

import '../../screens/auth/auth.dart';
import '../../shared/shared.dart';

class SocialMediaLogin extends StatelessWidget {
  SocialMediaLogin(
      {Key? key, this.onPressFacebook, this.onPressGoogle, this.onPressApple})
      : super(key: key);

  final VoidCallback? onPressFacebook;

  final VoidCallback? onPressGoogle;

  final VoidCallback? onPressApple;

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.gray1,
              ),
            ),
            SizedBox(width: 10),
            StyleText(
              text: 'Or',
              fontSize: 12,
              fontFamily: AppFonts.primary,
              textColor: AppColors.gray1,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.gray1,
              ),
            ),
          ]),
        ),
        SizedBox(height: 40),
        Obx(
          () => Column(mainAxisSize: MainAxisSize.max, children: [
            SocialMediaBtn(
              btnColor: AppColors.facebook,
              iconColor: Colors.white,
              textBtn: 'sign_in_with_facebook'.tr,
              isLoading: _authController.isLoadingBtn['facebook'] ?? false,
              onPress: onPressFacebook!,
              textColor: Colors.white,
              icon: FontAwesomeIcons.facebook,
            ),
            // TODO: - Temporarily remove sign in with apple
            // Column(
            //   children: [
            //     SizedBox(height: 15),
            //     SocialMediaBtn(
            //       btnColor: AppColors.white,
            //       iconColor: Colors.black,
            //       textBtn: 'sign_in_with_apple'.tr,
            //       isLoading: _authController.isLoadingBtn['apple'] ?? false,
            //       onPress: onPressApple!,
            //       textColor: AppColors.text,
            //       icon: FontAwesomeIcons.apple,
            //     ),
            //   ],
            // ),
            SizedBox(height: 15),
            SocialMediaBtn(
              btnColor: Colors.white,
              textBtn: 'sign_in_with_google'.tr,
              isLoading: _authController.isLoadingBtn['google'] ?? false,
              onPress: onPressGoogle!,
              iconColor: AppColors.red1,
              icon: FontAwesomeIcons.google,
              textColor: AppColors.text,
            ),
          ]),
        ),
      ],
    );
  }
}
