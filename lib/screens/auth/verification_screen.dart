import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/screens/auth/controllers/controllers.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/focus.dart';
import 'package:neko_wallet/widgets/back_button.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends GetView<VerificationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScreen(
        backgroundColor: Colors.blue.shade50,
        key: controller.scaffoldKey,
        isLoading: controller.isLoading,
        child: Container(
          child: Column(
            children: [
              CustomBackButton(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonWidget.rowHeight(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: FlareActor(
                          "assets/otp.flr",
                          animation: "otp",
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.center,
                        ),
                      ),
                      CommonWidget.smallRowHeight(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: StyleText(
                            text: 'email_verification'.tr,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8),
                        child: RichText(
                          text: TextSpan(
                              text: "enter_the_code_sent_to".tr,
                              children: [
                                TextSpan(
                                    text: controller.email,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.primary,
                                        fontSize: 15)),
                              ],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CommonWidget.rowHeight(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 22.0, right: 22.0),
                        child: Form(
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
                                // shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 60,
                                fieldWidth: 40,
                                activeColor: Colors.black,
                                selectedColor: Colors.black,
                                errorBorderColor: Colors.red,
                                inactiveColor: Colors.black,
                                activeFillColor:
                                    controller.errorMessage.value.isNotEmpty
                                        ? Colors.red
                                        : Colors.black,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              textStyle: TextStyle(fontSize: 20, height: 1.6),
                              backgroundColor: Colors.blue.shade50,
                              validator: (pincode) {
                                if (pincode != null) {
                                  if (pincode.isEmpty)
                                    return CommonError
                                        .VERIFICATION_CODE_INVALID;
                                  if (pincode.length < 6)
                                    return CommonError
                                        .VERIFICATION_CODE_INVALID;
                                }
                                return null;
                              },
                              // enableActiveFill: true,
                              errorAnimationController:
                                  controller.errorController,
                              controller: controller.textEditingController,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                AppFocus.unfocus(context);
                                controller.onPressVerify();
                              },
                              onChanged: (value) {},
                              beforeTextPaste: (text) => true,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Obx(
                          () => controller.errorMessage.value.isNotEmpty
                              ? StyleText(
                                  text: controller.errorMessage.value,
                                  textColor: Colors.red,
                                  fontSize: CommonConstants.text12,
                                  fontWeight: FontWeight.w400)
                              : Container(),
                        ),
                      ),
                      CommonWidget.rowHeight(height: 20),
                      Obx(
                        () => RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "didnt_receive_the_code".tr + "? ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: CommonConstants.text16),
                              children: [
                                TextSpan(
                                    text: " " +
                                        "resend".tr +
                                        "${controller.timer.value == null ? '' : ' (_timer.value.tick)'}",
                                    recognizer: controller.onTapRecognizer,
                                    style: TextStyle(
                                        color: Colors.blue.shade200,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.primary,
                                        decoration: TextDecoration.underline,
                                        fontSize: CommonConstants.text16))
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => ButtonCT(
                    title: "verify".tr,
                    isLoading: controller.isLoading,
                    buttonStyle: ButtonCTStyle(
                      buttonColor: Colors.white,
                      titleColor: Colors.white,
                      gradient: CommonConstants.primaryGradient,
                    ),
                    onPressButton: controller.onPressVerify),
              ),
              CommonWidget.rowHeight(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
