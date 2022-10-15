import 'package:get/get.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/contact_model.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:neko_wallet/widgets/header_ct.dart';
import 'package:neko_wallet/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/recommed_amount_money.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/send_money.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class SendMoneyAmount extends StatefulWidget {
  const SendMoneyAmount({Key? key, this.selectedContact, this.onChangeState})
      : super(key: key);

  final Contact? selectedContact;

  final ValueChanged<SendMoneyState>? onChangeState;

  @override
  _SendMoneyAmountState createState() => _SendMoneyAmountState();
}

class _SendMoneyAmountState extends State<SendMoneyAmount> {
  String _errorText = '';

  List<int> _recommendAmount = [];

  final _selectedAmount = ''.obs;

  _onChangeAmount(String amount) {
    // Check amount is not empty
    if (amount.trim().isEmpty) {
      // Remove all prev recommendations
      List<int> removeList = [];
      _recommendAmount.forEach((element) {
        removeList.add(element);
      });

      _recommendAmount.removeWhere((element) => removeList.contains(element));

      setState(() {});
      return;
    }

    // Convert to number
    int? recommendedAmount = int.tryParse(amount);

    if (recommendedAmount != null) {
      setState(() {
        // Remove error text
        _errorText = '';

        // Remove all prev recommendations
        List<int> removeList = [];
        _recommendAmount.forEach((element) {
          removeList.add(element);
        });

        _recommendAmount.removeWhere((element) => removeList.contains(element));

        for (var i = 0; i < 3; i++) {
          recommendedAmount = recommendedAmount! * 10;
          _recommendAmount.add(recommendedAmount!);
        }
      });
    } else {
      setState(() {
        _errorText = 'Invalid number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray4,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        HeaderCT(
                            title: 'Transfer amount',
                            iconSize: 30,
                            titleStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: HexColor.fromHex('#353333'),
                            ),
                            onPressIcon: () => Get.back(),
                            rightIcon: CommonWidget.svgImage('ic_new_income')),
                        Container(
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Row(
                            children: [
                              Obx(
                                () => InputCT(
                                  title: "Input nominal",
                                  placeholder: "Enter amount",
                                  value: _selectedAmount.value,
                                  errorText: _errorText,
                                  isDebounced: true,
                                  needValidation: false,
                                  onChangeText: _onChangeAmount,
                                  keyboardType: TextInputType.number,
                                  isHighLightBorder: true,
                                  isCurrency: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => RecommendAmountMoney(
                                data: _recommendAmount,
                                onPressRecommended: (value) {
                                  _selectedAmount.value = value.toString();
                                },
                              ),
                            ),
                            Center(
                              child: StyleText(
                                text: '+ Admin fee 5%',
                                textColor: HexColor.fromHex('#EF6874'),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: ButtonCT(
                            onPressButton: () {
                              this
                                  .widget
                                  .onChangeState!(SendMoneyState.sentMoney);
                            },
                            title: 'Send money',
                            buttonStyle: ButtonCTStyle(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              buttonColor: Colors.white,
                              titleColor: Colors.white,
                              borderColor: Colors.transparent,
                              radius: 8,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.2, 0.9],
                                  colors: [
                                    HexColor.fromHex('#9DEB93'),
                                    AppColors.blue1,
                                  ],
                                  tileMode: TileMode.clamp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
