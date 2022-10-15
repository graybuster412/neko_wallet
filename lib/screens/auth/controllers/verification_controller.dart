import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/data/api/api.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../shared/shared.dart';
import 'auth_controller.dart';
import '../../../routes/router.dart';

class VerificationController extends GetxController {
  final ApiRepository apiRepository;

  VerificationController({required this.apiRepository});

  final AuthController _authController = Get.find();

  TextEditingController textEditingController = TextEditingController();

  var onTapRecognizer;

  late StreamController<ErrorAnimationType> errorController;

  final errorMessage = "".obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  Rx<Timer?> timer = null.obs;

  bool get isLoading {
    return _authController.isLoading.value;
  }

  String get email {
    return _authController.user.value.email ?? "";
  }

  @override
  void onReady() {
    onTapRecognizer = TapGestureRecognizer()..onTap = _onTapResend;

    errorController = StreamController<ErrorAnimationType>();

    super.onReady();
  }

  @override
  void dispose() {
    errorController.close();

    timer.value?.cancel();

    super.dispose();
  }

  onPressVerify() {
    formKey.currentState?.validate();

    errorMessage.value = "";

    // Validate verification code
    if (formKey.currentState?.validate() == false) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation

      // errorMessage.value = CommonError.VERIFICATION_CODE_INVALID;
    } else {
      errorMessage.value = "";

      Get.toNamed(RouteManager.RESET_PASSWORD);
    }
  }

  String? getError(String key) {
    return _authController.getError(key);
  }

  _onTapResend() {
    if (email.isEmpty) {
      return;
    }

    if (timer.value != null && timer.value!.tick < 60) {
      return;
    }

    timer.value = Timer.periodic(Duration(minutes: 1), (timer) {
      if (timer.tick == 0) {
        this.timer.value?.cancel();

        this.timer.value = null;
      }
    });
  }

  onChangeText(String email) {
    _authController.handleError();

    _authController.user.value.email = email;
  }

  onPressSend() {
    _authController.handleRequestResetPassword();
  }
}
