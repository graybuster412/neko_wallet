import 'package:get/get.dart';
import 'package:neko_wallet/screens/auth/controllers/controllers.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:flutter/material.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/input_text.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/back_button.dart';

class RegisterScreen extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        backgroundColor: Colors.white,
        isLoading: controller.isLoading,
        child: Form(
          key: controller.formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 22.0, top: 22.0, right: 22.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          onPress: () => Get.back(),
                        ),
                        CommonWidget.rowHeight(height: 40),
                        GradientText(
                          text: "register_for_free".tr,
                          colors: AppColors.primaryGradientColors,
                        ),
                        CommonWidget.rowHeight(height: 22),
                        Obx(() => InputCT(
                              returnKeyboardType: TextInputAction.next,
                              placeholder: "your_name".tr,
                              validator: (username) {
                                if (username == null) return null;

                                if (username.isEmpty || username.length < 3) {
                                  return CommonError.INVALID_USERNAME;
                                }
                              },
                              onSubmit: (value) =>
                                  controller.inputRefs['email']?.requestFocus(),
                              focusNode: controller.inputRefs['username'],
                              errorText: controller.getError('username') ?? '',
                              onChangeText: (nickname) {
                                controller.onChangeText(nickname: nickname);
                              },
                            )),
                        CommonWidget.smallRowHeight(),
                        Obx(() => InputCT(
                              placeholder: "your_email".tr,
                              validator: (email) {
                                if (email == null) return null;

                                if (!Validator.shared
                                    .validateEmail(email: email)) {
                                  return CommonError.INVALID_EMAIL;
                                }
                                return null;
                              },
                              focusNode: controller.inputRefs['email'],
                              errorText: controller.getError('email') ?? '',
                              capitalization: TextCapitalization.none,
                              returnKeyboardType: TextInputAction.next,
                              onSubmit: (value) => controller
                                  .inputRefs['password']
                                  ?.requestFocus(),
                              keyboardType: TextInputType.emailAddress,
                              onChangeText: (email) {
                                controller.onChangeText(email: email);
                              },
                            )),
                        CommonWidget.smallRowHeight(),
                        Obx(() => InputCT(
                              returnKeyboardType: TextInputAction.next,
                              placeholder: "password".tr,
                              isInputPassword: true,
                              controller:
                                  controller.textControllers['password'],
                              validator: (password) {
                                if (password == null) return null;

                                if (!Validator.shared
                                    .validatePassword(password: password)) {
                                  return CommonError.INVALID_PASSWORD;
                                }

                                if (password.trim().isNotEmpty &&
                                    password !=
                                        controller
                                            .textControllers['confirmPassword']
                                            ?.text) {
                                  return CommonError.CONFIRM_PASSWORD_NOT_MATCH;
                                }
                                return null;
                              },
                              focusNode: controller.inputRefs['password'],
                              isSecuredEntry: true,
                              onSubmit: (value) =>
                                  controller.inputRefs['password']?.unfocus(),
                              errorText: controller.getError('password') ?? '',
                              onChangeText: (password) {
                                controller.onChangeText(password: password);
                              },
                            )),
                        CommonWidget.smallRowHeight(),
                        Obx(
                          () => InputCT(
                            placeholder: "confirm_password".tr,
                            isInputPassword: true,
                            controller:
                                controller.textControllers['confirmPassword'],
                            returnKeyboardType: TextInputAction.done,
                            validator: (confirmPassword) {
                              if (confirmPassword == null) return null;

                              if (confirmPassword.trim().isNotEmpty &&
                                  confirmPassword !=
                                      controller
                                          .textControllers['confirmPassword']
                                          ?.text) {
                                return CommonError.CONFIRM_PASSWORD_NOT_MATCH;
                              }
                              return null;
                            },
                            errorText:
                                controller.getError('confirmPassword') ?? '',
                            isSecuredEntry: true,
                            onChangeText: (password) {
                              controller.onChangeText(
                                  confirmedPassword: password);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => ButtonCT(
                      title: "register".tr,
                      isLoading: controller.isLoading,
                      buttonStyle: ButtonCTStyle(
                        buttonColor: Colors.white,
                        titleColor: Colors.white,
                        borderColor: Colors.transparent,
                        gradient: CommonConstants.primaryGradient,
                      ),
                      onPressButton: controller.onPressRegiser),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
