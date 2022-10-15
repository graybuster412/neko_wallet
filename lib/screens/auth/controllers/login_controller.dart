import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/utils/focus.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  final AuthController _authController = Get.find();

  late Map<String, FocusNode> inputRefs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isLoading {
    return _authController.isLoading.value;
  }

  bool get isFirebaseAuthLoading {
    return _authController.isLoadingBtn['firebase'] ?? false;
  }

  String? getError(String field) {
    return _authController.getError(field);
  }

  onChangeEmail(String email) {
    _authController.handleError(field: 'email');

    _authController.user.value.email = email;
  }

  onChangePassword(String password) {
    _authController.handleError(field: 'password');

    _authController.password.value = password;
  }

  void onPressLogin(BuildContext context) {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    AppFocus.unfocus(context);
    _authController.signIn();
  }

  signInWithGoogle(BuildContext context) {
    AppFocus.unfocus(context);

    _authController.signInWithGoogle();
  }

  signInWithFacebook(BuildContext context) {
    AppFocus.unfocus(context);

    _authController.signInWithFacebook();
  }

  signInWithApple(BuildContext context) {
    AppFocus.unfocus(context);

    _authController.signInWithApple();
  }

  @override
  void onInit() {
    super.onInit();
    inputRefs = {"email": FocusNode(), "password": FocusNode()};
  }

  @override
  void dispose() {
    inputRefs['email']?.dispose();
    inputRefs['password']?.dispose();

    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    // Clear all error messages
    _authController.handleError();
  }
}
