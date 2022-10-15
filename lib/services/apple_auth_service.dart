import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthService {
  static final shared = AppleAuthService();

  signInWithApple() async {
    // final credential = await SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    //   webAuthenticationOptions: WebAuthenticationOptions(
    //     clientId: 'de.lunaone.flutter.signinwithappleexample.service',

    //     redirectUri:
    //         // For web your redirect URI needs to be the host of the "current page",
    //         // while for Android you will be using the API server that redirects back into your app via a deep link
    //         kIsWeb
    //             ? Uri.parse('https://${window.location.host}/')
    //             : Uri.parse(
    //                 'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
    //               ),
    //   ),
    //   // TODO: Remove these if you have no need for them
    //   nonce: 'example-nonce',
    //   state: 'example-state',
    // );

    // // This is the endpoint that will convert an authorization code obtained
    // // via Sign in with Apple into a session in your system
    // final signInWithAppleEndpoint = Uri(
    //   scheme: 'https',
    //   host: 'flutter-sign-in-with-apple-example.glitch.me',
    //   path: '/sign_in_with_apple',
    //   queryParameters: <String, String>{
    //     'code': credential.authorizationCode,
    //     if (credential.givenName != null) 'firstName': credential.givenName!,
    //     if (credential.familyName != null) 'lastName': credential.familyName!,
    //     'useBundleId':
    //         !kIsWeb && (Platform.isIOS || Platform.isMacOS) ? 'true' : 'false',
    //     if (credential.state != null) 'state': credential.state!,
    //   },
    // );
  }
}
