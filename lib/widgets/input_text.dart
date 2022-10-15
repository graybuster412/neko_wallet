import 'dart:async';

import 'package:get/get.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/currency.dart';
import 'package:flutter/material.dart';

class InputCT extends StatefulWidget {
  final String? title;

  final String? subTitle;

  final String? placeholder;

  final String? errorText;

  final String value;

  final bool isDebounced;

  final bool isError;

  final bool isSecuredEntry;

  final bool isInputPassword;

  final TextInputType keyboardType;

  final FocusNode? focusNode;

  final ValueChanged<String>? onSubmit;

  final String? Function(String?)? validator;

  final TextInputAction returnKeyboardType;

  final bool isHighLightBorder;

  final bool isCurrency;

  final bool needValidation;

  final TextEditingController? controller;

  final ValueChanged<String>? onChangeText;

  final TextCapitalization capitalization;

  InputCT(
      {Key? key,
      this.title,
      this.subTitle,
      this.placeholder,
      this.errorText,
      this.isDebounced = false,
      this.value = '',
      this.isError = false,
      this.isSecuredEntry = false,
      this.validator,
      this.isInputPassword = false,
      this.needValidation = true,
      this.returnKeyboardType: TextInputAction.done,
      this.focusNode,
      this.onSubmit,
      this.onChangeText,
      this.controller,
      this.isCurrency = false,
      this.capitalization = TextCapitalization.words,
      this.isHighLightBorder = false,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  _InputCTState createState() => _InputCTState();
}

class _InputCTState extends State<InputCT> {
  Rx<bool?> _isValidInput = Rx(null);

  final _isSecureEntry = false.obs;

  String _text = '';

  Timer? _debounce;

  @override
  void dispose() {
    widget.focusNode?.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isSecureEntry.value = widget.isSecuredEntry;
  }

  @override
  void didUpdateWidget(covariant InputCT oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.value != oldWidget.value) {
      widget.controller?.text = this.widget.value;

      _text = this.widget.value;
    }
  }

  Widget sufixIcon() {
    final Widget correctSvgIcon =
        CommonWidget.svgImage('ic_correct', size: Size(40, 40));
    final Widget incorrectSvgIcon =
        CommonWidget.svgImage('ic_false', size: Size(40, 40));
    if (widget.needValidation) {
      if (widget.isInputPassword && widget.isSecuredEntry) {
        return Container(
          width: 44,
          height: 44,
          child: IconButton(
            onPressed: () {
              _isSecureEntry.value = !_isSecureEntry.value;
            },
            icon: Icon(
              // Based on password visible state choose the icon
              !_isSecureEntry.value ? Icons.visibility : Icons.visibility_off,
              size: 22.0,
              color: AppColors.gray1,
            ),
          ),
        );
      } else if (_isValidInput.value != null) {
        return Container(
          width: 44,
          height: 44,
          padding: EdgeInsets.only(top: 8.0, left: 10.0),
          child: Center(
            child:
                _isValidInput.value == true ? correctSvgIcon : incorrectSvgIcon,
          ),
        );
      }
    }

    return Container();
  }

  _onChangeText(String value) {
    _text = value;
    // Validate email
    if (widget.keyboardType == TextInputType.emailAddress) {
      _isValidInput.value = value.isValidEmail();
    } else {
      _isValidInput.value = value.isNotEmpty && value.length > 3;
    }
    final onChangedText = widget.onChangeText ?? (value) {};
    onChangedText(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            widget.title != null
                ? StyleText(
                    text: widget.title!,
                    fontSize: 14,
                    textColor: AppColors.gray1,
                  )
                : Container(),
            widget.subTitle != null
                ? StyleText(
                    text: widget.subTitle!,
                    fontSize: 14,
                    textColor: AppColors.gray1,
                  )
                : Container(),
          ]),
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: widget.isCurrency && _text.trim().isNotEmpty
                      ? AppColors.blue1
                      : AppColors.gray1),
            )),
            child: Row(
              children: [
                widget.isCurrency
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CurrencyCT(
                          currency: 'USD',
                          backgroundColors: AppColors.primaryGradientColors,
                          isFilledGradient: true,
                          borderStyle:
                              Border.all(width: 1, color: Colors.transparent),
                        ),
                      )
                    : Container(),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => TextFormField(
                      cursorColor: Colors.black,
                      textCapitalization: this.widget.capitalization,
                      controller: widget.controller,
                      obscureText: _isSecureEntry.value,
                      keyboardType: widget.keyboardType,
                      focusNode: widget.focusNode,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: widget.returnKeyboardType,
                      onFieldSubmitted: widget.onSubmit,
                      validator: widget.validator,
                      onChanged: (value) {
                        if (widget.isDebounced) {
                          if (_debounce?.isActive == false) _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            _onChangeText(value);
                          });
                        } else {
                          _onChangeText(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(
                          color: AppColors.gray1,
                        ),
                        focusColor: Colors.black,
                        errorStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.primary,
                          color: Colors.red,
                        ),
                        fillColor: Colors.black,
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.isError
                                  ? Colors.red
                                  : widget.isCurrency && _text.trim().isNotEmpty
                                      ? AppColors.blue1
                                      : AppColors.gray1),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Obx(() => sufixIcon()),
              ],
            ),
          ),
          // widget.errorText?.trim().isNotEmpty == true
          //     ? Padding(
          //         padding: const EdgeInsets.only(top: 5.0),
          //         child: Container(
          //             child: StyleText(
          //           text: widget.errorText ?? '',
          //           fontSize: 12,
          //           fontFamily: AppFonts.primary,
          //           textColor: Colors.red,
          //         )),
          //       )
          //     : Container(),
        ],
      ),
    );
  }
}
