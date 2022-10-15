import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/credit_card_view_model.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/shared/colors.dart';
import 'package:neko_wallet/shared/common_widget.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_wallet_screen/add_recipient.dart';
import '../../widgets/my_wallet_screen/cart_latest_transactions.dart';
import '../../widgets/my_wallet_screen/credit_card.dart';
import '../../widgets/my_wallet_screen/interest_ct.dart';
import '../../widgets/my_wallet_screen/pagination_swipe_bar.dart';
import '../../widgets/my_wallet_screen/send_money/send_money.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen();

  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final currentIndex = 0.obs;

  final List<CreditCardViewModel> creditCards = [
    CreditCardViewModel(
        cardHolder: 'Kelvin Pham',
        cardNumber: '1234123412341234',
        type: 'visa',
        currency: '1234',
        currencyType: 'US',
        expiredDate: DateTime.now().toString()),
    CreditCardViewModel(
        cardHolder: 'Kelvin Pham',
        cardNumber: '1234123412341234',
        type: 'visa',
        currency: '1234',
        currencyType: 'US',
        expiredDate: DateTime.now().toString()),
    CreditCardViewModel(
        cardHolder: 'Kelvin Pham',
        cardNumber: '1234123412341234',
        type: 'visa',
        currency: '1234',
        currencyType: 'US',
        expiredDate: DateTime.now().toString())
  ];

  @override
  void initState() {
    super.initState();
    currentIndex.value =
        creditCards.isNotEmpty ? (creditCards.length / 2).floor() : 0;
  }

  _onPageChanged(int index, carousel) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white2,
      body: Container(
        child: Stack(
          children: [
            ListView(
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.only(top: 0, bottom: 24.0),
              scrollDirection: Axis.vertical,
              children: [
                Stack(children: [
                  HeaderGradient(
                    title: 'my_wallet'.tr,
                    iconSize: 40,
                    height: 238,
                    isCurved: true,
                    gradient: makeLinearGradient(
                        start: Alignment(-2, 0),
                        end: Alignment(4, 3),
                        colors: AppColors.primaryGradientColors),
                    onPressRightIcon: () =>
                        Get.toNamed(RouteManager.NOTIFICATION),
                    padding: EdgeInsets.only(
                      left: 22.0,
                      top: MediaQuery.of(context).padding.top + 19,
                      right: 20,
                    ),
                    rightIcon: CommonWidget.svgImage('icon_noti'),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      padding: new EdgeInsets.only(
                        top: 238 / 2,
                      ),
                      child: Column(children: [
                        Obx(
                          () => CarouselSlider.builder(
                              itemCount: creditCards.length,
                              options: CarouselOptions(
                                  onPageChanged: _onPageChanged,
                                  height: 184.0,
                                  scrollDirection: Axis.horizontal,
                                  enlargeCenterPage: true,
                                  initialPage: currentIndex.value),
                              itemBuilder: (BuildContext context, index, i) =>
                                  CreditCard(
                                    backgroundColor: this.currentIndex ==
                                            creditCards
                                                .indexOf(creditCards[index])
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.9),
                                    key: Key('$index'),
                                    size: Size(
                                        MediaQuery.of(context).size.width -
                                            44.0,
                                        173.0),
                                    creditCardModel: creditCards[index],
                                    visaIcon: CommonWidget.svgImage('visa'),
                                    creditCardTypeColor: AppColors.blue2,
                                    currencyBorderStyle: Border.all(
                                        width: 1, color: Colors.transparent),
                                    currencyColors: AppColors.primaryGradientColors,
                                  )),
                        ),
                        SizedBox(height: 22.0),
                        Obx(
                          () => PaginationSwipeBar(
                              currentIndex: this.currentIndex.value,
                              listOfItems: creditCards),
                        ),
                      ]))
                ]),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InterestCT(
                            containerWidth:
                                (MediaQuery.of(context).size.width / 2) - 30,
                            title: 'income'.tr,
                            content: '\$ 1,150.00',
                            progress: 0.5,
                            progressColor:
                                makeLinearGradient(colors: AppColors.primaryGradientColors)),
                        SizedBox(width: 15.0),
                        InterestCT(
                            containerWidth:
                                (MediaQuery.of(context).size.width / 2) - 30,
                            title: 'spent'.tr,
                            content: '\$ 800.00',
                            progress: 0.1,
                            progressColor: makeLinearGradient(colors: [
                              HexColor.fromHex('#F27473'),
                              HexColor.fromHex('#E73E79'),
                            ])),
                      ]),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
                  child: AddRecipient(
                      onPress: () => showPopup(context, SendMoney())),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: CartLatestTransaction(onChangedTab: (value) {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
