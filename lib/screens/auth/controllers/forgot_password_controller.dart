import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/data/api/api.dart';

import 'auth_controller.dart';

class ForgotPasswordController extends GetxController {
  final ApiRepository apiRepository;

  ForgotPasswordController({required this.apiRepository});

  final AuthController _authController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var onTapRecognizer;

  Rx<Timer?> timer = null.obs;

  bool get isLoading {
    return _authController.isLoading.value;
  }

  @override
  void onReady() {
    onTapRecognizer = TapGestureRecognizer()..onTap = _onTapResend;

    super.onReady();
  }

  @override
  void dispose() {
    timer.value?.cancel();

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

  onChangeText(String email) {
    _authController.handleError();

    _authController.user.value.email = email;
  }

  onPressSend() {
    if (formKey.currentState?.validate() == false) return;

    _authController.handleRequestResetPassword();
  }
}
