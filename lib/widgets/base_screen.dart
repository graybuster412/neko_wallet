import 'package:flutter/material.dart';

import '../shared/shared.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen(
      {Key? key,
      this.isLoading: false,
      required this.child,
      this.useSafeArea: true,
      this.gradient,
      this.onWillPop,
      this.appBar,
      this.resizeToAvoidBottomInset,
      this.statusBarColor,
      this.backgroundColor: AppColors.white})
      : super(key: key);

  final bool isLoading;

  final bool useSafeArea;

  final Widget child;

  final Color backgroundColor;

  final bool? resizeToAvoidBottomInset;

  final AppBar? appBar;

  final Future<bool> Function()? onWillPop;

  final LinearGradient? gradient;

  final LinearGradient? statusBarColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: isLoading,
        child: Scaffold(
            key: this.key,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appBar,
            backgroundColor: backgroundColor,
            body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: useSafeArea
                    ? Container(
                        decoration: BoxDecoration(gradient: statusBarColor),
                        child: SafeArea(
                            child: WillPopScope(
                          onWillPop: () async {
                            if (this.onWillPop != null) {
                              return this.onWillPop!();
                            }
                            return Future.value(false);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: backgroundColor, gradient: gradient),
                              child: child),
                        )),
                      )
                    : WillPopScope(
                        onWillPop: () async {
                          if (this.onWillPop != null) {
                            return this.onWillPop!();
                          }
                          return Future.value(false);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: backgroundColor, gradient: gradient),
                            child: child),
                      ))));
  }
}
