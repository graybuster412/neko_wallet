import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class DropdownCT extends StatefulWidget {
  DropdownCT({Key? key, this.selectedValue, this.icon, this.items: const []})
      : super(key: key);

  final selectedValue;

  final List<String> items;

  final Widget? icon;

  @override
  _DropdownCTState createState() => _DropdownCTState();
}

class _DropdownCTState extends State<DropdownCT> {
  final _dropdownValue = ''.obs;

  @override
  void initState() {
    super.initState();
    _dropdownValue.value = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 25.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.gray3, width: 1)),
          width: MediaQuery.of(context).size.width / 2 - 50,
          child: DropdownButton<dynamic>(
            value: _dropdownValue.value,
            iconSize: 16,
            icon: widget.icon,
            itemHeight: 80,
            elevation: 0,
            hint: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray3, width: 1),
                  ),
                  child: StyleText(text: _dropdownValue.value, fontSize: 13),
                ),
              ),
            ),
            style: TextStyle(color: AppColors.text, fontSize: 13),
            underline: Container(
              height: 0,
              color: AppColors.transparent,
            ),
            onChanged: (newValue) {
              if (newValue != null) {
                _dropdownValue.value = newValue;
              }
            },
            items: widget.items.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: new Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  width: MediaQuery.of(context).size.width / 2 - 78,
                  child: StyleText(text: item, fontSize: 13),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
