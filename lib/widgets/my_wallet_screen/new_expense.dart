import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:neko_wallet/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neko_wallet/widgets/style_text.dart';

import '../../shared/shared.dart';
import '../dropdown/drop_down_ct.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class DropdownItem {
  final String value;
  final String title;

  const DropdownItem({required this.value, required this.title});
}

class ExpenseItem extends DropdownItem {
  const ExpenseItem({value, title}) : super(value: value, title: title);
}

class _NewExpenseState extends State<NewExpense> {
  Map<String, String> _errorObject = {
    'expense': '',
    'notes': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
          alignment: Alignment.bottomCenter,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StyleText(
                              text: 'Input Expense',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              textColor: HexColor.fromHex('#353333'),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SizedBox(child: AppSvgs.cancel),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownCT(
                              icon: AppSvgs.dropdown,
                              items: [
                                'Food & Drink',
                                'Games',
                                'Internet',
                              ],
                              selectedValue: 'Food & Drink',
                            ),
                            DropdownCT(
                              icon: AppSvgs.dropdown,
                              items: [
                                '18 Sept 2018',
                                '19 Sept 2018',
                                '20 Sept 2018',
                              ],
                              selectedValue: '18 Sept 2018',
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Row(
                            children: [
                              InputCT(
                                title: "How much?",
                                placeholder: "Enter expense",
                                errorText: _errorObject['expense'],
                                onChangeText: (text) {},
                                isHighLightBorder: true,
                                isCurrency: true,
                              ),
                            ],
                          ),
                        ),
                        InputCT(
                          title: "Notes",
                          placeholder: "Enter notes",
                          isHighLightBorder: true,
                          errorText: _errorObject['notes'],
                          onChangeText: (text) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: ButtonCT(
                            onPressButton: () {},
                            title: 'Apply',
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
