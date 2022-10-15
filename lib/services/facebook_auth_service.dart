import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../shared/shared.dart';

enum FacebookAuthStatus { failed, cancelled, success, inprogress }

class FacebookAuthResult {
  String? accessToken;
  FacebookAuthStatus? status;
  String? error;

  FacebookAuthResult({
    this.accessToken,
    this.status,
    this.error,
  });
}

class FacebookAuthService {
  static final shared = FacebookAuthService();

  final _facebookAuth = FacebookAuth.instance;

  logout() async {
    await _facebookAuth.logOut();
  }

  isLoggin() async {
    final result = await FacebookAuth.instance.accessToken;
    return result != null;
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      final result = await _facebookAuth.getUserData(
          fields:
              "name,picture.width(800).height(800),first_name,last_name,email");

      return result;
    } catch (error) {
      debugPrint('Failed to facebook user data: ${error.toString()}');
      return Future.value(null);
    }
  }

  Future<FacebookAuthResult> login() async {
    FacebookAuthResult data;
    try {
      final result =
          await _facebookAuth.login(permissions: ['email', 'public_profile']);

      switch (result.status) {
        case LoginStatus.success:
          final accessToken = result.accessToken?.token;

          if (accessToken == null || accessToken.isEmpty) {
            // Failed to get token from facebook throws error
            debugPrint('Failed to get facebook token');
            data = FacebookAuthResult(
                accessToken: null,
                status: FacebookAuthStatus.failed,
                error: CommonError.FB_LOGIN_FAILED);
          } else {
            data = FacebookAuthResult(
                accessToken: result.accessToken?.token,
                status: FacebookAuthStatus.success,
                error: null);
          }
          break;
        case LoginStatus.cancelled:
          data = FacebookAuthResult(
              accessToken: null,
              status: FacebookAuthStatus.cancelled,
              error: CommonError.FB_LOGIN_FAILED);
          break;
        case LoginStatus.failed:
          debugPrint(
              'Failed to sign in with facebook: ${result.message ?? ''}');
          data = FacebookAuthResult(
              accessToken: null,
              status: FacebookAuthStatus.failed,
              error: CommonError.FB_LOGIN_FAILED);
          break;
        case LoginStatus.operationInProgress:
          data = FacebookAuthResult(
              accessToken: null,
              status: FacebookAuthStatus.inprogress,
              error: null);
          break;
      }
    } catch (error) {
      debugPrint('Failed to sign in with facebook: ${error.toString()}');
      data = FacebookAuthResult(
          accessToken: null,
          status: FacebookAuthStatus.failed,
          error: CommonError.FB_LOGIN_FAILED);
    }
    return data;
  }
}
