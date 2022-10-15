import 'package:flutter_svg/flutter_svg.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/contact_model.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/header_ct.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/receipt_info.dart';

class PaymentReceipt extends StatelessWidget {
  const PaymentReceipt({Key? key, this.selectedContact}) : super(key: key);

  final Contact? selectedContact;

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
                    HeaderCT(
                        title: 'Payment Receipt',
                        iconSize: 30,
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: HexColor.fromHex('#353333'),
                        ),
                        onPressIcon: () => Navigator.pop(context),
                        rightIcon: AppSvgs.cancel),
                    Opacity(
                      opacity: 0.5,
                      child: ReceiptInfo(
                        detail: '20/09/2018',
                        detailValue: '10:30:24',
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: HexColor.fromHex('#353333'),
                        ),
                        detailStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: HexColor.fromHex('#353333'),
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    ReceiptInfo(
                      title: 'Transaction ID',
                      detail: '#ID-12345',
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: HexColor.fromHex('#353333'),
                      ),
                    ),
                    SizedBox(height: 22),
                    ReceiptInfo(
                      title: 'Transaction Type',
                      detail: 'Money Transfer',
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: HexColor.fromHex('#353333'),
                      ),
                    ),
                    SizedBox(height: 22),
                    ReceiptInfo(
                      title: 'Sent To',
                      detail: selectedContact?.name ?? "",
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: HexColor.fromHex('#353333'),
                      ),
                    ),
                    SizedBox(height: 22),
                    ReceiptInfo(
                      title: 'Nominal',
                      detail: '\$125.0',
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: HexColor.fromHex('#353333'),
                      ),
                    ),
                    SizedBox(height: 22),
                    ReceiptInfo(
                      title: 'Status',
                      detail: 'Success',
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: AppColors.blue1,
                      ),
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: ButtonCT(
                        onPressButton: () {},
                        title: 'Download Receipt',
                        buttonStyle: ButtonCTStyle(
                          height: 60,
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
          )),
    );
  }
}
