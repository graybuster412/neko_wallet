import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/models/user_model.dart';
import 'package:neko_wallet/services/services.dart';
import 'package:neko_wallet/shared/shared.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  RxBool isLoggedIn = false.obs;

  Rx<User?> firebaseUser = null.obs;

  var user = UserModel().obs;

  var password = "".obs;

  var confirmedPassword = "".obs;

  var verificationCode = "".obs;

  var isLoading = false.obs;

  final isLoadingBtn = {
    "facebook": false,
    "google": false,
    "firebase": false,
    "apple": false
  }.obs;

  final _errorObject = {
    "email": '',
    "password": '',
    "username": "",
    "confirmPassword": "",
    "verificationCode": "",
  }.obs;

  String? getError(String field) {
    return _errorObject[field];
  }

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(FirebaseManager.shared.auth.currentUser);

    handleFetchUserProfile();
  }

  handleError({String? field = null, String errorText: ''}) {
    switch (field) {
      case 'email':
        _errorObject['email'] = errorText;
        break;
      case 'password':
        _errorObject['password'] = errorText;
        break;
      case 'username':
        _errorObject['username'] = errorText;
        break;
      case 'confirmPassword':
        _errorObject['confirmPassword'] = errorText;
        break;
      case 'verificationCode':
        _errorObject['verificationCode'] = errorText;
        break;
      default:
        // Case empty error
        _errorObject['email'] = '';
        _errorObject['password'] = '';
        _errorObject['username'] = '';
        _errorObject['confirmPassword'] = '';
        _errorObject['verificationCode'] = '';
        break;
    }
  }

  onChangeUser(Rx<UserModel> newUser) {
    user = newUser;
  }

  handleFetchUserProfile() async {
    try {
      final userId = firebaseUser.value?.uid;

      if (userId == null || userId.isEmpty) {
        return;
      }

      final currentUser =
          await FirebaseManager.shared.getUserProfileWith(userId);

      if (currentUser != null) {
        this.user.value = currentUser;
      }
    } catch (e) {
      debugPrint('failed to get user profile ${e}');
    }
  }

  handleRequestResetPassword() async {
    try {
      if (user.value.email == null ||
          user.value.email?.trim().isEmpty == true) {
        handleError(field: 'email', errorText: CommonError.INVALID_EMAIL);
        return;
      }

      isLoading.value = true;

      await FirebaseManager.shared.resetPasswordWith(user.value.email!);

      CommonWidget.showSnackbar(
          title: 'reset_password'.tr,
          message: "a_reset_password_link_sent"
              .trParams({"email": user.value.email ?? "email"}));

      Future.delayed(Duration(milliseconds: 3500), () => Get.back());
    } on FirebaseAuthErrorCode catch (e) {
      if (e == FirebaseAuthErrorCode.NonexistUser) {
        handleError(field: 'email', errorText: CommonError.NONEXIST_EMAIL);
      } else if (e == FirebaseAuthErrorCode.TooManyRequests) {
        CommonWidget.showSnackbar(
            title: 'reset_password'.tr, message: CommonError.TOO_MANY_REQUESTS);
      } else {
        CommonWidget.showSnackbar(
            title: 'reset_password'.tr, message: CommonError.LOGIN_FAILED);
      }
    } finally {
      isLoading.value = false;
    }
  }

  handleResendCode() async {
    try {
      if (user.value.email == null ||
          user.value.email?.trim().isEmpty == true) {
        handleError(field: 'email', errorText: CommonError.INVALID_EMAIL);
        return;
      }

      await FirebaseManager.shared.resetPasswordWith(user.value.email!);
    } on FirebaseAuthErrorCode catch (e) {
      if (e == FirebaseAuthErrorCode.NonexistUser) {
        handleError(field: 'email', errorText: CommonError.NONEXIST_EMAIL);
      } else if (e == FirebaseAuthErrorCode.TooManyRequests) {
        CommonWidget.showSnackbar(
            title: 'reset_password'.tr, message: CommonError.TOO_MANY_REQUESTS);
      } else {
        CommonWidget.showSnackbar(
            title: 'reset_password'.tr, message: CommonError.LOGIN_FAILED);
      }
    }
  }

  handleResetPassword() async {
    try {
      if (verificationCode.value.isEmpty || verificationCode.value.length < 6) {
        handleError(
            field: 'verificationCode',
            errorText: CommonError.VERIFICATION_CODE_INVALID);

        isLoading.value = false;
        return;
      }

      if (password.value.trim().isEmpty) {
        handleError(
            field: 'password', errorText: CommonError.INVALID_NEW_PASSWORD);

        isLoading.value = false;
        return;
      }

      if (password.value.trim().isNotEmpty &&
          !password.value.isValidPassword()) {
        handleError(
            field: 'password', errorText: CommonError.PASSWORD_WRONG_FORMAT);

        isLoading.value = false;
        return;
      }

      if (confirmedPassword.value.trim().isEmpty) {
        handleError(
            field: 'confirmPassword',
            errorText: CommonError.INVALID_CONFIRM_PASSWORD);

        isLoading.value = false;
        return;
      }

      if (confirmedPassword.value.trim().isNotEmpty &&
          confirmedPassword.value != password.value) {
        handleError(
            field: 'confirmPassword',
            errorText: CommonError.CONFIRM_PASSWORD_NOT_MATCH);

        isLoading.value = false;
        return;
      }

      isLoading.value = true;

      await FirebaseManager.shared
          .confirmPasswordReset(verificationCode.value, password.value);
    } on FirebaseAuthErrorCode catch (e) {
      if (e == FirebaseAuthErrorCode.WeakPassword) {
        handleError(field: 'password', errorText: CommonError.PASSWORD_SHORT);
      } else if (e == FirebaseAuthErrorCode.TooManyRequests) {
        CommonWidget.showSnackbar(
            title: 'reset_password'.tr, message: CommonError.TOO_MANY_REQUESTS);
      } else if (e == FirebaseAuthErrorCode.VerificationCodeExpired) {
        handleError(
            field: 'verificationCode',
            errorText: CommonError.VERIFICATION_CODE_EXPIRED);
      } else if (e == FirebaseAuthErrorCode.VerificationCodeInvalid) {
        handleError(
            field: 'verificationCode',
            errorText: CommonError.VERIFICATION_CODE_INVALID);
      } else {
        debugPrint("failed to sign in with GG");
        CommonWidget.showSnackbar(
            title: 'reset_password'.tr, message: CommonError.LOGIN_FAILED);
      }
    } finally {
      isLoading.value = false;
    }
  }

  signInWithGoogle() async {
    isLoadingBtn['google'] = true;

    isLoading.value = true;

    GoogleAuthResult googleAuthResult = await GoogleAuthService.shared.login();

    final status = googleAuthResult.status ?? GoogleAuthStatus.failed;

    switch (status) {
      case GoogleAuthStatus.success:
        final userId = await FirebaseManager.shared.signInGoogle(
            accessToken: googleAuthResult.accessToken!,
            idToken: googleAuthResult.idToken!);
        // Throw error if user id is empty or undefined
        if (userId == null || userId.isEmpty) {
          // sign out to the firebase
          signOut();
          debugPrint("empty user id");
          CommonWidget.showSnackbar(
              title: 'authentication'.tr, message: CommonError.GG_LOGIN_FAILED);
          return;
        }
        user.value.name = googleAuthResult.user?.displayName ?? '';

        user.value.email = googleAuthResult.user?.email ?? '';

        user.value.imageUrl = googleAuthResult.user?.photoUrl ?? '';

        addToUserDatabase(userId);
        break;
      case GoogleAuthStatus.cancelled:
        isLoadingBtn['google'] = false;

        isLoading.value = false;
        break;
      case GoogleAuthStatus.failed:
        isLoadingBtn['google'] = false;
        debugPrint("failed to sign in with GG ${googleAuthResult.error}");

        isLoading.value = false;
        CommonWidget.showSnackbar(
            title: 'authentication'.tr, message: CommonError.GG_LOGIN_FAILED);
        break;
    }
  }

  signInWithApple() async {}

  signInWithFacebook() async {
    isLoadingBtn['facebook'] = true;

    isLoading.value = true;

    final result = await FacebookAuthService.shared.login();

    FacebookAuthStatus status = result.status ?? FacebookAuthStatus.failed;

    switch (status) {
      case FacebookAuthStatus.success:
        String? accessToken = result.accessToken;

        // Create a credential from the access token
        final userId = await FirebaseManager.shared
            .signInFacebook(accessToken: accessToken!);

        // Throw error if user id is empty or undefined
        if (userId == null || userId.isEmpty) {
          // sign out to the firebase
          signOut();
          debugPrint("empty user id");
          CommonWidget.showSnackbar(
              title: 'authentication'.tr, message: CommonError.FB_LOGIN_FAILED);
          return;
        }

        // Get facebook user profile
        Map<String, dynamic> profile =
            await FacebookAuthService.shared.getUserData();

        user.value.name = profile['name'] as String;

        user.value.email = profile['email'] as String;

        user.value.imageUrl = profile['picture']['data']['url'] as String;

        isLoadingBtn['facebook'] = false;

        isLoading.value = false;

        addToUserDatabase(userId);

        break;
      case FacebookAuthStatus.cancelled:
        // Dismiss loading indicator when user cancelled facebook auth
        isLoadingBtn['facebook'] = false;

        isLoading.value = false;
        break;
      case FacebookAuthStatus.failed:
        String? message = result.error;
        isLoadingBtn['facebook'] = false;

        isLoading.value = false;

        debugPrint("failed to sign up ${message}");
        CommonWidget.showSnackbar(
            title: 'authentication'.tr, message: CommonError.FB_LOGIN_FAILED);
        break;
      case FacebookAuthStatus.inprogress:
        break;
    }
  }

  signOut() {
    // Signout all services
    GoogleAuthService.shared.logout();
    FacebookAuthService.shared.logout();
    FirebaseManager.shared.signOut();
    StorageService.saveBool(
        key: StorageConstants.isAuthenticated, value: false);
  }

  signIn() async {
    // if (!Validator.shared.validateEmail(email: user.value.email)) {
    //   handleError(field: 'email', errorText: CommonError.INVALID_EMAIL);
    //   isLoading.value = false;
    //   return;
    // }

    // if (!Validator.shared.validatePassword(password: password.value)) {
    //   handleError(field: 'password', errorText: CommonError.INVALID_PASSWORD);
    //   isLoading.value = false;
    //   return;
    // }

    isLoading.value = true;

    isLoadingBtn['firebase'] = true;

    // clear error message in the screen
    handleError();

    final result =
        await FirebaseManager.shared.signIn(user.value.email!, password.value);

    if (result.status == FirebaseAuthStatus.success) {
      Future.delayed(Duration(milliseconds: 500), () {
        // Wait for 0.5s to dismiss loading indicator
        isLoading.value = false;
      });
    } else {
      if (result.error == CommonError.NONEXIST_EMAIL) {
        handleError(field: 'email', errorText: CommonError.NONEXIST_EMAIL);
      } else if (result.error == CommonError.INVALID_EMAIL) {
        handleError(field: 'email', errorText: CommonError.INVALID_EMAIL);
      } else if (result.error == CommonError.INCORRECT_PASSWORD) {
        handleError(
            field: 'password', errorText: CommonError.INCORRECT_PASSWORD);
      } else {
        debugPrint("failed to sign in ${result.error}");
        CommonWidget.showSnackbar(
            title: 'authentication'.tr, message: CommonError.STH_WENT_WRONG);
      }
    }
    isLoading.value = false;

    isLoadingBtn['firebase'] = false;
  }

  Future<void> addToUserDatabase(String userId) async {
    try {
      final existedUser =
          await FirebaseManager.shared.getUserProfileWith(userId);

      if (existedUser == null) {
        FirebaseManager.shared.databaseRef.child("Users").child(userId).set({
          'email': user.value.email,
          'username': user.value.name,
          "uid": userId,
          'image': user.value.imageUrl,
        });
      }
    } catch (e) {
      debugPrint('Failed to add to database: ${e}');
    }
  }

  signUp() async {
    isLoading.value = true;

    // clear all error messages in the screen
    handleError();

    final result = await FirebaseManager.shared
        .register(user.value.email!, password.value);

    if (result.status == FirebaseAuthStatus.success) {
      // Add new user to database
      if (result.user?.uid != null) {
        addToUserDatabase(result.user!.uid);
      }
    } else {
      if (result.error == CommonError.EXISTED_EMAIL) {
        handleError(field: 'email', errorText: result.error!);
      } else if (result.error == CommonError.PASSWORD_SHORT) {
        handleError(field: 'password', errorText: result.error!);
      } else if (result.error == CommonError.INVALID_EMAIL) {
        handleError(field: 'email', errorText: result.error!);
      } else {
        debugPrint("failed to sign up ${result.error}");
        CommonWidget.showSnackbar(
            title: 'authentication'.tr, message: CommonError.STH_WENT_WRONG);
      }
    }

    isLoading.value = false;
  }
}
