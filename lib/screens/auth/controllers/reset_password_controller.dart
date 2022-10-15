import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/data/api/api.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'auth_controller.dart';

class ResetPasswordController extends GetxController {
  final ApiRepository apiRepository;

  ResetPasswordController({required this.apiRepository});

  final AuthController _authController = Get.find();

  var onTapRecognizer;

  Map<String, TextEditingController> textControllers = {};

  final TextEditingController otpController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  Rx<Timer?> timer = null.obs;

  bool get isLoading {
    return _authController.isLoading.value;
  }

  String get email {
    return _authController.user.value.email ?? '';
  }

  @override
  void onInit() {
    onTapRecognizer = TapGestureRecognizer()..onTap = _onTapResend;

    errorController = StreamController<ErrorAnimationType>();

    textControllers = {
      "password": TextEditingController(),
      "confirmPassword": TextEditingController(),
    };

    super.onInit();
  }

  @override
  void dispose() {
    errorController.close();

    timer.value?.cancel();

    textControllers['password']?.dispose();

    textControllers['confirmPassword']?.dispose();

    otpController.dispose();

    super.dispose();
  }

  String? getError(String key) {
    return _authController.getError(key);
  }

  _onTapResend() {
    if (_authController.user.value.email?.isEmpty == true) {
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

  onChange(String field, String value) {
    _authController.handleError();

    switch (field) {
      case 'password':
        _authController.password.value = value;
        break;
      case 'confirmPassword':
        _authController.confirmedPassword.value = value;
        break;
      case 'code':
        _authController.verificationCode.value = value;
        break;
      default:
    }
  }

  onPressResetPassword() {
    if (_authController.verificationCode.value.length < 6) {
      errorController.add(ErrorAnimationType.shake);
      return;
    }

    if (formKey.currentState?.validate() == false) {
      return;
    }

    _authController.handleResetPassword();
  }
}
