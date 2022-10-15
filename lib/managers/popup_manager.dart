import 'package:flutter/material.dart';
import '../widgets/activity_Indicator.dart';

class PopupManager {
  static final PopupManager shared = PopupManager._internal();

  factory PopupManager() {
    return shared;
  }

  ActivityIndicator? indicator = null;

  late OverlayEntry overlayEntry;

  PopupManager._internal();

  showIndicator(
      {required BuildContext context,
      String title = 'Loading...',
      bool isLoading = true}) {
    OverlayState? overlayState = Overlay.of(context);

    if (indicator != null) {
      indicator = null;
    }
    indicator = ActivityIndicator(title: title, isLoading: isLoading);
    final size = MediaQuery.of(context).size;

    OverlayEntry overlayEntry = OverlayEntry(
        opaque: true,
        builder: (context) => Positioned(
            width: size.width,
            height: size.height,
            child: Material(child: indicator)));
    overlayState?.insert(overlayEntry);
  }

  closeIndicator() {
    overlayEntry.remove();
  }
}
