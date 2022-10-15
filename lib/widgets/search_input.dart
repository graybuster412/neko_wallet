import 'package:flutter/material.dart';
import 'package:neko_wallet/theme/fonts.dart';
import '../extensions/hex_color.dart';

class SearchInput extends StatefulWidget {
  final String placeholder;

  final ValueChanged<String>? onChangeText;

  final TextEditingController? controller;

  SearchInput({
    Key? key,
    required this.placeholder,
    this.onChangeText,
    this.controller,
  }) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: HexColor.fromHex('#C4C2CB'), width: 1),
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromRGBO(196, 194, 203, 0.1)),
        constraints: BoxConstraints(
            minHeight: 50, minWidth: MediaQuery.of(context).size.width - 40),
        child: Row(
          children: [
            SizedBox(child: Icon(Icons.search), height: 20, width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: TextField(
                  controller: widget.controller,
                  textInputAction: TextInputAction.search,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: widget.onChangeText,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(
                      color: HexColor.fromHex('#696565'),
                    ),
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: AppFonts.primary,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
