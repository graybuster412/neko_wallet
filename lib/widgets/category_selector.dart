import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/shared/shared.dart';

class CategorySelector extends StatefulWidget {
  CategorySelector({Key? key}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final selectedIndex = 0.obs;
  final List<String> categories = [
    'messages'.tr,
    'online'.tr,
    'groups'.tr,
    'requests'.tr
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  child: Obx(
                    () => StyleText(
                        text: categories[index],
                        textColor: index == selectedIndex
                            ? Colors.white
                            : Colors.white60,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                ));
          },
        ));
  }
}
