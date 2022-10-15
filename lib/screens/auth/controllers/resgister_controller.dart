import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/utils/focus.dart';

import '../../../shared/shared.dart';
import 'auth_controller.dart';

class RegisterController extends GetxController {
  final AuthController _authController = Get.find();

  late Map<String, FocusNode> inputRefs;

  late Map<String, TextEditingController> textControllers;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isLoading {
    return _authController.isLoading.value;
  }

  String? getError(String field) {
    return _authController.getError(field);
  }

  onChangeText(
      {String? email = null,
      String? password = null,
      String? nickname = null,
      String? confirmedPassword = null}) {
    _authController.handleError();

    if (email != null) {
      _authController.handleError(field: 'email');

      _authController.user.value.email = email;
    } else if (nickname != null) {
      _authController.handleError(field: 'username');

      _authController.user.value.name = nickname;
    } else if (password != null) {
      _authController.handleError(field: 'password');

      _authController.password.value = password;
    } else if (confirmedPassword != null) {
      _authController.confirmedPassword.value = confirmedPassword;

      if (confirmedPassword.isEmpty) {
        _authController.handleError(field: 'confirmPassword');
      }

      if (_authController.password.value.isNotEmpty &&
          confirmedPassword.length > 3) {
        if (_authController.password.value != confirmedPassword) {
          _authController.handleError(
              field: 'confirmPassword',
              errorText: CommonError.CONFIRM_PASSWORD_NOT_MATCH);
        }
      }
    }
  }

  onPressRegiser() async {
    if (Get.context != null) {
      AppFocus.unfocus(Get.context!);
    }

    if (formKey.currentState?.validate() == false) {
      return;
    }

    // Clear all error message
    _authController.handleError();

    _authController.signUp();
  }

  @override
  void onInit() {
    super.onInit();
    _authController.handleError();

    inputRefs = {
      "email": FocusNode(),
      "username": FocusNode(),
      "password": FocusNode()
    };

    textControllers = {
      "confirmPassword": TextEditingController(),
      "password": TextEditingController()
    };
  }

  @override
  void onReady() {
    super.onReady();
    // Clear all error messages
    _authController.handleError();
  }

  @override
  void dispose() {
    inputRefs['email']?.dispose();
    inputRefs['username']?.dispose();
    inputRefs['password']?.dispose();

    textControllers['password']?.dispose();
    textControllers['confirmPassword']?.dispose();

    super.dispose();
  }
}
