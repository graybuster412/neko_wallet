import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class CustomBottomTabBarItem {
  CustomBottomTabBarItem({this.iconData, this.text: null});
  SvgPicture? iconData;
  String? text;
}

class CustomBottomTabBar extends StatefulWidget {
  CustomBottomTabBar({
    this.items: const [],
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    required this.onTabSelected,
  }) {}
  final List<CustomBottomTabBarItem> items;
  final String? centerItemText;
  final double? height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => CustomBottomTabBarState();
}

class CustomBottomTabBarState extends State<CustomBottomTabBar> {
  final _selectedIndex = 0.obs;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return Obx(
        () => _buildTabItem(
          item: widget.items[index],
          index: index,
          onPressed: _updateIndex,
        ),
      );
    });
    // items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      elevation: 0.0,
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    CustomBottomTabBarItem? item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color? color =
        _selectedIndex.value == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: item?.iconData,
                ),
                item?.text != null
                    ? StyleText(
                        text: item?.text ?? "",
                        textColor: color,
                        fontSize: 14,
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
