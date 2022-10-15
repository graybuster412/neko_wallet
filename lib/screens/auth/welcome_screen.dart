import 'package:get/get.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/utils.dart';
import '../../widgets/button_primary.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useSafeArea: false,
      onWillPop: () => Future.value(!Navigator.of(context).userGestureInProgress),
      backgroundColor: Theme.of(context).primaryColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
              gradient: makeLinearGradient(
            colors: AppColors.primaryGradientColors,
            start: Alignment(-1.0, -1),
            end: Alignment(-1.0, 1),
          )),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.circleUser,
                            size: 48,
                            color: Colors.white,
                          ),
                          CommonWidget.rowHeight(height: 20),
                          StyleText(
                              text: "welcome".tr,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                          SizedBox(height: 15),
                          StyleText(
                              text: "the_easiest_way".tr,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 21),
                          StyleText(
                              text: "manage_money".tr,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 21),
                        ]),
                  ),
                  CommonWidget.rowHeight(height: 35),
                  Column(
                    children: <Widget>[
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: ButtonCT(
                            title: "login".tr,
                            buttonStyle: ButtonCTStyle(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              fontWeight: FontWeight.w600,
                              buttonColor: Colors.white,
                              titleColor: AppColors.blue1,
                              borderColor: Colors.white,
                            ),
                            onPressButton: () =>
                                {Get.toNamed(RouteManager.LOGIN_SCREEN)}),
                      ),
                      CommonWidget.rowHeight(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: ButtonCT(
                            title: "register".tr,
                            buttonStyle: ButtonCTStyle(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              fontWeight: FontWeight.w600,
                              buttonColor: Colors.transparent,
                              titleColor: Colors.white,
                              borderColor: Colors.white,
                            ),
                            onPressButton: () =>
                                Get.toNamed(RouteManager.REGISTER_SCREEN)),
                      ),
                    ],
                  ),
                  CommonWidget.rowHeight(height: 15),
                  Center(
                    child: Opacity(
                      opacity: .7,
                      child: OnlyTextButton(
                          onPressed: () {},
                          text: "term_of_service".tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          textColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
