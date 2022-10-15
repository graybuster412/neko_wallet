import 'package:flutter/material.dart';

class NavigationManager {
  static final NavigationManager shared = NavigationManager._internal();

  factory NavigationManager() {
    return shared;
  }

  NavigationManager._internal();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
