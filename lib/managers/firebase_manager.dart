// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:neko_wallet/models/user_model.dart';
import 'package:neko_wallet/services/storage_service.dart';

import '../shared/shared.dart';

class FirebaseAuthErrorCode {
  static const String WeakPassword = 'weak-password';

  static const String ExistedEmail = 'email-already-in-use';

  static const String IncorrectPassword = 'wrong-password';

  static const String VerificationCodeExpired = 'expired-action-code';

  static const String VerificationCodeInvalid = 'invalid-action-code';

  static const String NonexistUser = 'user-not-found';

  static const String InvalidEmail = 'invalid-email';

  static const String TooManyRequests = 'too-many-requests';
}

enum FirebaseAuthStatus { failed, success }

class FirebaseAuthResult {
  FirebaseAuthStatus? status;
  User? user;
  String? error;

  FirebaseAuthResult({
    this.status,
    this.error,
    this.user,
  });
}

class FirebaseManager {
  static final shared = FirebaseManager();

  FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      debugPrint('Failed to sign out: ${e}');
      throw ('Failed to sign out. Please try again!');
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint('Failed to send email verification: ${e}');
      throw (e);
    }
  }

  Future<void> resetPasswordWith(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Failed to request reset password: ${e}');
      throw (e);
    }
  }

  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await auth.confirmPasswordReset(code: code, newPassword: newPassword);
    } catch (e) {
      debugPrint('Failed to reset password: ${e}');
      throw (e);
    }
  }

  Future<UserModel?> getUserProfileWith(String userId) async {
    try {
      final snapshot = await databaseRef.child("Users").child(userId).once();

      Map<dynamic, dynamic>? value = snapshot.value;

      if (value != null) {
        final user = UserModel();

        user.email = value['email'];

        user.name = value['username'];

        user.imageUrl = value['image'];

        user.id = userId;

        return user;
      }
      return null;
    } catch (e) {
      debugPrint('Failed to get user profile: ${e}');
      return null;
    }
  }

  Future<FirebaseAuthResult> register(String email, password) async {
    FirebaseAuthResult result;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      result = FirebaseAuthResult(
          error: null,
          status: FirebaseAuthStatus.success,
          user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign up: ${e.message}');
      String error;
      switch (e.code) {
        case FirebaseAuthErrorCode.ExistedEmail:
          error = CommonError.EXISTED_EMAIL;
          break;
        case FirebaseAuthErrorCode.WeakPassword:
          error = CommonError.PASSWORD_SHORT;
          break;
        case FirebaseAuthErrorCode.InvalidEmail:
          error = CommonError.INVALID_EMAIL;
          break;
        case FirebaseAuthErrorCode.TooManyRequests:
          error = CommonError.TOO_MANY_REQUESTS;
          break;
        default:
          error = CommonError.REGISTERED_FAILED;
          break;
      }

      result =
          FirebaseAuthResult(error: error, status: FirebaseAuthStatus.failed);
    } catch (e) {
      debugPrint('Failed to sign up: ${e.toString()}');
      result = FirebaseAuthResult(
          error: CommonError.LOGIN_FAILED, status: FirebaseAuthStatus.failed);
    }

    return result;
  }

  Future<void> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw (e);
    } catch (e) {
      debugPrint('Failed to send password reset: ${e}');
      throw (e);
    }
  }

  Future<String?> signInWithSocial({credential}) async {
    try {
      final result = await auth.signInWithCredential(credential);

      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw (e);
    } catch (e) {
      debugPrint('Failed to login with google: ${e.toString()}');
      throw (e);
    }
  }

  Future<String?> signInFacebook({required String accessToken}) async {
    try {
      final facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken);

      final userId = await signInWithSocial(credential: facebookAuthCredential);

      return userId;
    } on FirebaseAuthException catch (e) {
      throw (e);
    } catch (e) {
      debugPrint('Failed to login with google: ${e.toString()}');
      throw (e);
    }
  }

  Future<String?> signInGoogle(
      {required String accessToken, required String idToken}) async {
    try {
      final credential = GoogleAuthProvider.credential(
          accessToken: accessToken, idToken: idToken);

      final userId = await signInWithSocial(credential: credential);

      return userId;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to login with google: ${e.toString()}');
      return null;
    } catch (e) {
      debugPrint('Failed to login with google: ${e.toString()}');
      return null;
    }
  }

  Future<FirebaseAuthResult> signIn(String email, String password) async {
    FirebaseAuthResult result;
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      result =
          FirebaseAuthResult(error: null, status: FirebaseAuthStatus.success);

      if (authResult.user?.emailVerified == true) {
        StorageService.saveBool(
            key: StorageConstants.isAuthenticated, value: true);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign in: ${e.code}');
      String error;
      switch (e.code) {
        case FirebaseAuthErrorCode.NonexistUser:
          error = CommonError.NONEXIST_EMAIL;
          break;
        case FirebaseAuthErrorCode.IncorrectPassword:
          error = CommonError.INCORRECT_PASSWORD;
          break;
        case FirebaseAuthErrorCode.InvalidEmail:
          error = CommonError.INVALID_EMAIL;
          break;
        case FirebaseAuthErrorCode.TooManyRequests:
          error = CommonError.TOO_MANY_REQUESTS;
          break;
        default:
          error = CommonError.LOGIN_FAILED;
          break;
      }

      result =
          FirebaseAuthResult(error: error, status: FirebaseAuthStatus.failed);
    } catch (e) {
      debugPrint('Failed to login: ${e.toString()}');
      result = FirebaseAuthResult(
          error: CommonError.LOGIN_FAILED, status: FirebaseAuthStatus.failed);
    }

    return result;
  }
}
