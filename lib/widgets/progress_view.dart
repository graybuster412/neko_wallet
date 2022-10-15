import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  const ProgressView(
      {Key? key,
      this.size: const Size(0, 0),
      this.propress: 0.0,
      this.progressColor})
      : super(key: key);

  final Size size;

  final double propress;

  final LinearGradient? progressColor;

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _percent = 0.0;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 0.0, end: widget.propress).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        setState(() {
          _percent = _animation.value ?? 0.0;
        });
      });
    _animationController.forward(from: 0.0);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProgressView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.propress != widget.propress) {
      _animationController.duration = Duration(seconds: 1);
      _animation =
          Tween(begin: oldWidget.propress, end: widget.propress).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear),
      );
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      decoration: BoxDecoration(
          color: HexColor.fromHex('#F6F6F6'),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Align(
        alignment: Alignment.topLeft,
        child: FractionallySizedBox(
          widthFactor: _percent,
          heightFactor: 1,
          child: Container(
              decoration: BoxDecoration(
                  gradient: widget.progressColor,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)))),
        ),
      ),
    );
  }
}
