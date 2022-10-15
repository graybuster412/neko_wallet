import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/screens/auth/auth.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../widgets/back_button.dart';
import '../../widgets/input_text.dart';
import '../../widgets/button_primary.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        isLoading: controller.isLoading,
        backgroundColor: AppColors.white,
        child: Container(
          padding: EdgeInsets.only(left: 22.0, top: 22.0, right: 22.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CustomBackButton(onPress: Get.back),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StyleText(
                                    text: "reset_password".tr,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    fontFamily: AppFonts.primary,
                                    textLinearGradient:
                                        CommonConstants.textLinearGradient),
                                SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                      text: "enter_the_code_sent_to".tr,
                                      children: [
                                        TextSpan(
                                            text: controller.email,
                                            style: TextStyle(
                                                fontFamily: AppFonts.primary,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ],
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontFamily: AppFonts.primary,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Form(
                              key: controller.formKey,
                              child: Obx(
                                () => PinCodeTextField(
                                  appContext: context,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  length: 6,
                                  obscureText: false,
                                  obscuringCharacter: '*',
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 60,
                                    fieldWidth: 40,
                                    activeColor: Colors.grey.shade300,
                                    selectedColor: Colors.grey.shade300,
                                    inactiveColor: Colors.grey.shade300,
                                    activeFillColor: controller
                                                .getError('verificationCode')
                                                ?.isNotEmpty ==
                                            true
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    height: 1.6,
                                    fontFamily: AppFonts.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  errorAnimationController:
                                      controller.errorController,
                                  controller: controller.otpController,
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) {},
                                  onChanged: (value) =>
                                      controller.onChange('code', value),
                                  beforeTextPaste: (text) {
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => StyleText(
                                  text:
                                      controller.getError('verificationCode') ??
                                          '',
                                  textColor: Colors.red,
                                  fontFamily: AppFonts.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5),
                            Obx(
                              () => RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "didnt_receive_the_code".tr + " ?",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                    children: [
                                      TextSpan(
                                          text: controller.timer.value != null
                                              ? 'resend'.tr
                                              : 'resend'.tr +
                                                  '(${controller.timer.value!.tick})',
                                          recognizer:
                                              controller.onTapRecognizer,
                                          style: TextStyle(
                                              color: Colors.blue.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: AppFonts.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16))
                                    ]),
                              ),
                            ),
                            Container(
                              child: Obx(
                                () => InputCT(
                                  placeholder: "enter_new_password".tr,
                                  keyboardType: TextInputType.emailAddress,
                                  controller:
                                      controller.textControllers['password'],
                                  onChangeText: (value) =>
                                      controller.onChange('password', value),
                                  // errorText:
                                  //     controller.getError('password') ?? '',
                                  validator: (password) {
                                    if (password == null) return null;

                                    if (!Validator.shared
                                        .validatePassword(password: password)) {
                                      return CommonError.INVALID_PASSWORD;
                                    }

                                    if (password.trim().isNotEmpty &&
                                        password !=
                                            controller
                                                .textControllers[
                                                    'confirmPassword']
                                                ?.text) {
                                      return CommonError
                                          .CONFIRM_PASSWORD_NOT_MATCH;
                                    }
                                    return null;
                                  },
                                  isSecuredEntry: false,
                                ),
                              ),
                            ),
                            Container(
                              child: Obx(
                                () => InputCT(
                                  placeholder: "enter_confirm_password".tr,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller
                                      .textControllers['confirmPassword'],
                                  onChangeText: (value) => controller.onChange(
                                      'confirmPassword', value),
                                  // errorText:
                                  //     controller.getError('confirmPassword') ??
                                  //         '',
                                  validator: (confirmPassword) {
                                    if (confirmPassword == null) return null;

                                    if (confirmPassword.trim().isNotEmpty &&
                                        confirmPassword !=
                                            controller
                                                .textControllers[
                                                    'confirmPassword']
                                                ?.text) {
                                      return CommonError
                                          .CONFIRM_PASSWORD_NOT_MATCH;
                                    }
                                    return null;
                                  },
                                  isSecuredEntry: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => ButtonCT(
                  title: "reset".tr,
                  isLoading: controller.isLoading,
                  buttonStyle: ButtonCTStyle(
                      buttonColor: Colors.white,
                      titleColor: Colors.white,
                      borderColor: Colors.transparent,
                      gradient: CommonConstants.primaryGradient),
                  onPressButton: controller.onPressResetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
