import 'package:flutter/material.dart';

class BasicPopup extends StatelessWidget {
  const BasicPopup(
      {Key? key,
      this.onClosePopup,
      this.backgroundColor: const Color.fromRGBO(0, 0, 0, 0.401636),
      this.child})
      : super(key: key);

  @required
  final VoidCallback? onClosePopup;

  final Color backgroundColor;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: InkResponse(
      onTap: onClosePopup,
      child: Container(
          color: this.backgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: child),
    ));
  }
}
