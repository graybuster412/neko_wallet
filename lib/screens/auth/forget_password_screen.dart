import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/screens/auth/controllers/controllers.dart';
import 'package:neko_wallet/shared/shared.dart';
import '../../widgets/back_button.dart';
import '../../widgets/input_text.dart';
import '../../widgets/button_primary.dart';

class ForgetPasswordScreen extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        backgroundColor: AppColors.white,
        isLoading: controller.isLoading,
        child: Container(
          padding: EdgeInsets.only(left: 22.0, top: 22.0, right: 22.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(onPress: Get.back),
                        CommonWidget.rowHeight(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyleText(
                                text: "forgot_password".tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                textLinearGradient:
                                    CommonConstants.textLinearGradient),
                            CommonWidget.rowHeight(height: 20),
                            StyleText(
                              text: "the_email_you_want_to_reset".tr,
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.gray2,
                              fontSize: 15,
                            ),
                            CommonWidget.rowHeight(height: 20),
                            Obx(
                              () => InputCT(
                                placeholder: "enter_email".tr,
                                keyboardType: TextInputType.emailAddress,
                                capitalization: TextCapitalization.none,
                                onChangeText: controller.onChangeText,
                                validator: (email) {
                                  if (email == null) return null;

                                  if (!Validator.shared
                                      .validateEmail(email: email)) {
                                    return CommonError.INVALID_EMAIL;
                                  }
                                  return null;
                                },
                                errorText: controller.getError('email') ?? '',
                                isSecuredEntry: false,
                              ),
                            ),
                            CommonWidget.rowHeight(height: 20),
                            Obx(
                              () => RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "didnt_receive_the_link".tr + "? ",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                    children: [
                                      TextSpan(
                                          text: (controller.timer.value !=
                                                      null &&
                                                  controller
                                                          .timer.value!.tick ==
                                                      0)
                                              ? 'resend'.tr
                                              : 'resend'.tr +
                                                  '(${controller.timer.value!.tick})',
                                          recognizer:
                                              controller.onTapRecognizer,
                                          style:
                                              TextStyle(
                                                  color: Colors.blue.shade400,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: AppFonts.primary,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 15))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => ButtonCT(
                  title: "send".tr,
                  isLoading: controller.isLoading,
                  buttonStyle: ButtonCTStyle(
                      buttonColor: Colors.white,
                      titleColor: Colors.white,
                      borderColor: Colors.transparent,
                      gradient: CommonConstants.primaryGradient),
                  onPressButton: controller.onPressSend,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
