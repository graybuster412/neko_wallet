import '../shared/shared.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    // Password should contain at least 1 upper character ,1 number, and special character.
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
        .hasMatch(this);
  }
}

class Validator {
  static final shared = Validator();

  bool validateEmail({String? email}) {
    if (email == null || email.trim().isEmpty == true) {
      return false;
    }
    if (!email.isValidEmail()) {
      return false;
    }
    return true;
  }

  bool validatePassword({String? password, bool isNewlyRegistered: false}) {
    if (password == null || password.trim().isEmpty == true) {
      return false;
    }
    if (isNewlyRegistered && !password.isValidPassword()) {
      return false;
    }
    return true;
  }
}
