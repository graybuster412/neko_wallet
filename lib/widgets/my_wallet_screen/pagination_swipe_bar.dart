import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class PaginationSwipeBar extends StatelessWidget {
  const PaginationSwipeBar(
      {Key? key, this.currentIndex: 0, this.listOfItems: const []})
      : super(key: key);

  final int currentIndex;

  final List<dynamic> listOfItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 3.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listOfItems.map((e) {
            final index = listOfItems.indexOf(e);
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                    key: Key('$index'),
                    child: CommonWidget.svgImage("icon_swipe_bar",
                        color: index != currentIndex
                            ? AppColors.gray1
                            : AppColors.blue1));
              },
            );
          }).toList()),
    );
  }
}
