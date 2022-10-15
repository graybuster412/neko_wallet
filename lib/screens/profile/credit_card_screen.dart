import 'package:neko_wallet/models/credit_card_view_model.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/my_wallet_screen/credit_card.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen();

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  List<CreditCardViewModel> _creditCard =
      (Get.arguments as List<CreditCardViewModel>);

  Widget _buildListItem(int index, CreditCardViewModel creditCard) {
    return CreditCard(
      gradient: makeLinearGradient(
        colors: creditCardGradientColor(),
        start: Alignment(1.0, -1),
        end: Alignment(0, 4),
      ),
      key: Key('$index'),
      visaIcon: CommonWidget.svgImage('visa_white'),
      size: Size(MediaQuery.of(context).size.width - 44.0, 173.0),
      creditCardModel: creditCard,
      creditCardTypeColor: Colors.white.withOpacity(0.1),
      currencyBorderStyle: Border.all(width: 1, color: Colors.transparent),
      currencyColors: [Colors.white.withOpacity(0.1)],
      useWhiteTextColor: true,
      margin: EdgeInsets.only(
          top: index == 0 ? 0 : 20,
          bottom: index == _creditCard.length - 1 ? 40 : 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white2,
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderGradient(
                title: 'credit_card'.tr,
                isCurved: false,
                gradient: makeLinearGradient(colors: AppColors.primaryGradientColors),
                leftIcon: CommonWidget.svgImage('ic_back_white'),
                onPressLeftIcon: () => Get.back(),
                iconSize: 36,
                padding: EdgeInsets.only(
                  left: 22.0,
                  top: MediaQuery.of(context).padding.top > 20
                      ? MediaQuery.of(context).padding.top + 15
                      : MediaQuery.of(context).padding.top + 30,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _creditCard.length,
                    itemBuilder: (context, int index) =>
                        _buildListItem(index, _creditCard[index])),
              ),
            ]);
      }),
    );
  }
}
