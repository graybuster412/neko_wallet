import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class OptionItem {
  final String id;
  final String title;

  OptionItem({required this.id, required this.title});
}

class CustomExpandedDropDown extends StatefulWidget {
  CustomExpandedDropDown(
      {Key? key,
      this.itemSelected,
      this.dropListModel: const [],
      this.onOptionSelected})
      : super(key: key);

  final OptionItem? itemSelected;

  final List<OptionItem> dropListModel;

  final ValueChanged<OptionItem>? onOptionSelected;

  @override
  _CustomExpandedDropDownState createState() =>
      _CustomExpandedDropDownState(itemSelected, dropListModel);
}

class _CustomExpandedDropDownState extends State<CustomExpandedDropDown>
    with SingleTickerProviderStateMixin {
  OptionItem? optionItemSelected;

  List<OptionItem> dropListModel;

  late AnimationController expandController;

  late Animation<double> animation;

  bool _isShow = false;

  _CustomExpandedDropDownState(this.optionItemSelected, this.dropListModel);

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (_isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.only(top: 15),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isShow = !_isShow;
                    _runExpandCheck();
                    setState(() {});
                  },
                  child: StyleText(
                    text: optionItemSelected?.title ?? "",
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, 4))
                ],
              ),
              child: _buildDropListOptions(dropListModel, context)),
        ),
      ],
    );
  }

  Widget _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade200, width: 1)),
                ),
                child: StyleText(
                    text: item.title,
                    fontSize: 16,
                    fontWeight: item.title == optionItemSelected?.title
                        ? FontWeight.bold
                        : FontWeight.w400,
                    lines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        onTap: () {
          this.optionItemSelected = item;
          _isShow = false;
          expandController.reverse();
          widget.onOptionSelected!(item);
        },
      ),
    );
  }
}
