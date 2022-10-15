import 'dart:convert';

import 'package:crypto/crypto.dart';

class CommonFunction {
  static String getHashPassword(String rawPassword) {
    var bytes = utf8.encode(rawPassword); // data being hashed
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String getPhoneNumberWithCountryCode(String phoneNumber) {
    var result = phoneNumber.substring(1);
    return "+84$result";
  }

  static wait(int milliseconds, Function callback) async {
    Future.delayed(Duration(milliseconds: milliseconds), () {
      callback();
    });
  }
}
