import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/widgets/auth/social_media_login.dart';
import '../../shared/shared.dart';
import '../../widgets/back_button.dart';
import '../../widgets/input_text.dart';
import '../../widgets/button_primary.dart';
import 'controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        isLoading: controller.isLoading,
        backgroundColor: AppColors.white2,
        child: Form(
          key: controller.formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 20.0, top: 22.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomBackButton(
                    onPress: () => Get.back(),
                  ),
                  Column(
                    children: [
                      CommonWidget.rowHeight(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StyleText(
                                  text: "welcome".tr + "!",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  textLinearGradient:
                                      CommonConstants.textLinearGradient),
                              SizedBox(height: 5.0),
                              StyleText(
                                  text: "let_get_started_for_free".tr,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.gray2),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 44.0),
                            child: InputCT(
                              placeholder: "enter_email".tr,
                              keyboardType: TextInputType.emailAddress,
                              capitalization: TextCapitalization.none,
                              returnKeyboardType: TextInputAction.next,
                              focusNode: controller.inputRefs['email'],
                              onSubmit: (value) => controller
                                  .inputRefs['password']
                                  ?.requestFocus(),
                              onChangeText: controller.onChangeEmail,
                              validator: (email) {
                                if (email == null) return null;

                                if (!Validator.shared
                                    .validateEmail(email: email)) {
                                  return CommonError.INVALID_EMAIL;
                                }
                                return null;
                              },
                              // errorText: controller.getError("email") ?? '',
                              isSecuredEntry: false,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: InputCT(
                              placeholder: "enter_password".tr,
                              capitalization: TextCapitalization.none,
                              isInputPassword: true,
                              validator: (password) {
                                if (password == null) return null;

                                if (!Validator.shared
                                    .validatePassword(password: password)) {
                                  return CommonError.INVALID_PASSWORD;
                                }

                                return null;
                              },
                              focusNode: controller.inputRefs['password'],
                              onSubmit: (value) =>
                                  controller.inputRefs['password']?.unfocus(),
                              // errorText:
                              //     controller.getError("password") ?? '',
                              isSecuredEntry: true,
                              onChangeText: controller.onChangePassword,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 35.0),
                                child: OnlyTextButton(
                                  text: 'forgot_password'.tr + " ?",
                                  onPressed: () => Get.toNamed(
                                      RouteManager.FORGOT_PASSWORD_SCREEN),
                                  fontSize: 14,
                                  textColor: AppColors.gray2.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 22.0),
                            // constraints: BoxConstraints.expand(
                            //   height: 50.0,
                            //   width: MediaQuery.of(context).size.width - 44,
                            // ),
                            child: Obx(
                              () => ButtonCT(
                                  title: "login".tr,
                                  isLoading: controller.isFirebaseAuthLoading,
                                  buttonStyle: ButtonCTStyle(
                                    width: MediaQuery.of(context).size.width,
                                    buttonColor: Colors.white,
                                    titleColor: Colors.white,
                                    borderColor: Colors.transparent,
                                    gradient: CommonConstants.primaryGradient,
                                  ),
                                  onPressButton: () =>
                                      controller.onPressLogin(context)),
                            ),
                          ),
                          CommonWidget.rowHeight(height: 40),
                          SocialMediaLogin(
                            onPressGoogle: () =>
                                controller.signInWithGoogle(context),
                            onPressFacebook: () =>
                                controller.signInWithFacebook(context),
                            onPressApple: () =>
                                controller.signInWithApple(context),
                          ),
                          CommonWidget.rowHeight(height: 20),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
