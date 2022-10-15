import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/send_money.dart';

import '../../../shared/shared.dart';

class SentMoneySuccessfully extends StatelessWidget {
  const SentMoneySuccessfully({Key? key, this.onChangeState}) : super(key: key);

  final ValueChanged<SendMoneyState>? onChangeState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.gray4,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        child: CommonWidget.pngImage('sent_money',
                            size: Size(148, 127))),
                    SizedBox(height: 32),
                    StyleText(
                      text: 'Money Sent!',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      textColor: HexColor.fromHex('#353333'),
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: ButtonCT(
                        onPressButton: () {
                          this.onChangeState!(SendMoneyState.receipt);
                        },
                        title: 'See Receipt',
                        buttonStyle: ButtonCTStyle(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          buttonColor: Colors.white,
                          titleColor: AppColors.blue1,
                          titleSize: 16,
                          borderColor: AppColors.blue1,
                          radius: 8,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
