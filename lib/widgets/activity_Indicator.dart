import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicator extends StatefulWidget {
  ActivityIndicator({Key? key, required this.title, this.isLoading: false})
      : super(key: key);

  final String title;

  final bool isLoading;

  @override
  _ActivityIndicatorState createState() => _ActivityIndicatorState();
}

class _ActivityIndicatorState extends State<ActivityIndicator> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return Container();
    }
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                  animating: widget.isLoading,
                ),
              ),
              SizedBox(height: 15.0),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
