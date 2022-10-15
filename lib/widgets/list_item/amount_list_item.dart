import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class AmountListItem extends StatefulWidget {
  const AmountListItem(
      {Key? key, this.onPress, required this.value, this.data: const []})
      : super(key: key);

  @required
  final VoidCallback? onPress;

  @required
  final int value;

  final List<int> data;

  @override
  State<StatefulWidget> createState() => _AmountListItemState();
}

class _AmountListItemState extends State<AmountListItem> {
  double _width = 0;

  double _height = 0;

  @override
  void didUpdateWidget(covariant AmountListItem oldWidget) {
    setState(() {
      _width = widget.data.isEmpty ? 0 : 50;

      _height = widget.data.isEmpty ? 0 : 30;
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkResponse(
        containedInkWell: true,
        onTap: widget.onPress,
        child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: AppColors.gray2, width: 0.5),
            ),
            height: _height,
            width: _width,
            child: Center(
              child: StyleText(
                text: '${widget.value}',
                lines: 1,
                textColor: AppColors.gray2,
                fontSize: 14,
              ),
            )),
      ),
    );
  }
}
