import 'package:flutter/services.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/dropdown/custom_expanded_dropdown.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class PhoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    if (newValue.text == '#' ||
        newValue.text == '*' ||
        newValue.text == ',' ||
        newValue.text == ';') {
      return new TextEditingValue(
        text: oldValue.text.toString(),
        selection: new TextSelection.collapsed(offset: oldValue.selection.end),
      );
    }
    if (newValue.text == '') {
      return new TextEditingValue(
        text: oldValue.text.toString(),
      );
    }
    final StringBuffer newText = new StringBuffer();
    if (oldValue.text.length == 0) {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ' ');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class MaskedTextController extends TextEditingController {
  MaskedTextController(
      {String? text, required this.mask, Map<String, RegExp>? translator})
      : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    this.addListener(() {
      var previous = this._lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        this.updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        this.updateText(this._lastUpdatedText);
      }
    });

    this.updateText(this.text);
  }

  late String mask;

  late Map<String, RegExp> translator;

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String? text) {
    if (text != null) {
      this.text = this._applyMask(this.mask, text);
    } else {
      this.text = '';
    }

    this._lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    this.updateText(this.text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    var text = this._lastUpdatedText;
    this.selection =
        new TextSelection.fromPosition(new TextPosition(offset: (text).length));
  }

  @override
  void set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      this.moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return {
      'A': new RegExp(r'[A-Za-z]'),
      '0': new RegExp(r'[0-9]'),
      '@': new RegExp(r'[A-Za-z0-9]'),
      '*': new RegExp(r'.*')
    };
  }

  String _applyMask(String mask, String value) {
    String result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (this.translator.containsKey(maskChar)) {
        if (this.translator[maskChar]?.hasMatch(valueChar) == true) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

class InputEditProfile extends StatefulWidget {
  final String title;

  final String? placeholder;

  final String? errorText;

  final String? value;

  final bool useDropdown;

  final bool isEditable;

  final TextInputType keyboardType;

  final ValueChanged<bool>? onFocus;

  final ValueChanged<String>? onSubmit;

  final TextInputAction returnKeyboardType;

  final ValueChanged<String>? onChangeText;

  final EdgeInsets padding;

  InputEditProfile(
      {Key? key,
      required this.title,
      this.placeholder,
      this.errorText,
      this.value = '',
      this.returnKeyboardType: TextInputAction.done,
      this.useDropdown = false,
      this.isEditable = true,
      this.onFocus,
      this.onSubmit,
      this.padding: EdgeInsets.zero,
      this.onChangeText,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  _InputEditProfileState createState() => _InputEditProfileState();
}

class _InputEditProfileState extends State<InputEditProfile> {
  FocusNode _focusNode = new FocusNode();

  bool _isValidInput = false;

  MaskedTextController _controller =
      MaskedTextController(mask: '(00) 000 000 0000');

  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_onFocusChange);

    _controller.text = widget.value ?? '';

    _textController.text = widget.value ?? '';
  }

  _onFocusChange() {
    widget.onFocus!(_focusNode.hasFocus);
  }

  _onChangeText(String value) {
    bool isInvalid = value.isEmpty;

    setState(() {
      _isValidInput = isInvalid;
    });
    if (widget.keyboardType == TextInputType.phone && value.length > 15) {
      return;
    }

    widget.onChangeText!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 74),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: HexColor.fromHex('#F6F6F6')),
      )),
      padding: widget.padding,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: StyleText(
                text: widget.title,
                textColor: HexColor.fromHex('#AFAFAF'),
                fontSize: 14,
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  !widget.useDropdown
                      ? TextField(
                          cursorColor: Colors.black,
                          maxLines: 1,
                          controller: widget.keyboardType == TextInputType.phone
                              ? _controller
                              : _textController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: widget.keyboardType,
                          focusNode: _focusNode,
                          enabled: this.widget.isEditable,
                          textInputAction: widget.returnKeyboardType,
                          onSubmitted: widget.onSubmit,
                          onChanged: (value) {
                            _onChangeText(value);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.placeholder,
                            hintStyle: TextStyle(
                              color: HexColor.fromHex('#AFAFAF'),
                            ),
                            contentPadding: EdgeInsets.only(top: 17),
                            focusColor: Colors.black,
                            fillColor: Colors.black,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: HexColor.fromHex(
                              '#353333',
                            ),
                          ),
                        )
                      : CustomExpandedDropDown(
                          dropListModel: [
                            OptionItem(id: 'Male', title: 'Male'),
                            OptionItem(id: 'Female', title: 'Female')
                          ],
                          itemSelected: OptionItem(
                              id: widget.value ?? '',
                              title: widget.value ?? ''),
                          onOptionSelected: (item) =>
                              widget.onChangeText!(item.title),
                        ),
                  !_isValidInput
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: StyleText(
                            text: widget.errorText ?? '',
                            fontSize: 10,
                            textColor: Colors.red,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ]),
    );
  }
}
