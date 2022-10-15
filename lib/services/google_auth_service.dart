import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../shared/shared.dart';

enum GoogleAuthStatus { failed, cancelled, success }

class GoogleAuthResult {
  String? accessToken;
  String? idToken;
  GoogleAuthStatus? status;
  String? error;
  GoogleSignInAccount? user;

  GoogleAuthResult({
    this.accessToken,
    this.idToken,
    this.status,
    this.error,
    this.user,
  });
}

class GoogleAuthService {
  static final shared = GoogleAuthService();

  final _googleSignIn = GoogleSignIn();

  logout() {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.disconnect();
    }
  }

  login() async {
    GoogleAuthResult data;

    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('failed to sign in with google');
        // Case cancelled where google user is null
        data = GoogleAuthResult(
            accessToken: null,
            idToken: null,
            status: GoogleAuthStatus.cancelled,
            error: CommonError.GG_LOGIN_FAILED);
      } else {
        // request access token and id token
        final googleAuth = await googleUser.authentication;

        if (googleAuth.accessToken == null && googleAuth.idToken == null) {
          debugPrint(
              'failed to sign in with google: missing access token or id token');
          data = GoogleAuthResult(
              accessToken: null,
              idToken: null,
              status: GoogleAuthStatus.failed,
              error: CommonError.GG_LOGIN_FAILED,
              user: null);
        } else {
          data = GoogleAuthResult(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
              status: GoogleAuthStatus.success,
              error: null,
              user: googleUser);
        }
      }
    } catch (error) {
      switch (error) {
        case GoogleSignIn.kSignInCanceledError:
          data = GoogleAuthResult(
              accessToken: null,
              idToken: null,
              status: GoogleAuthStatus.cancelled,
              error: null,
              user: null);
          break;
        default:
          debugPrint('Failed to sign in with google: ${error.toString()}');
          data = GoogleAuthResult(
              accessToken: null,
              idToken: null,
              status: GoogleAuthStatus.failed,
              error: CommonError.GG_LOGIN_FAILED,
              user: null);
      }
    }
    return data;
  }
}
