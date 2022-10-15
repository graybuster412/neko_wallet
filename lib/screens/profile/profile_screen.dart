import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/routes/router.dart';
import 'package:neko_wallet/screens/profile/controllers/controllers.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/profile/profile_item.dart';
import 'package:neko_wallet/widgets/widgets.dart';

import '../../shared/shared.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Container(
        child: Column(
          children: [
            HeaderGradient(
              title: 'account'.tr,
              isCurved: false,
              gradient: makeLinearGradient(colors: AppColors.primaryGradientColors),
              padding: EdgeInsets.only(
                left: 22.0,
                top: MediaQuery.of(context).padding.top > 20
                    ? isAndroid()
                        ? MediaQuery.of(context).padding.top + 30
                        : MediaQuery.of(context).padding.top + 15
                    : MediaQuery.of(context).padding.top + 25,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                shrinkWrap: true,
                children: [
                  Obx(
                    () => ProfileItem(
                        title: controller.currentUser.value?.name ?? "",
                        progress: 0.7,
                        hasSeperator: true,
                        isBoldTitle: true,
                        editProfile: true,
                        onPressEditProfile: () {
                          Get.toNamed(
                              RouteManager.PROFILE + RouteManager.EDIT_PROFILE);
                        },
                        disabled: true,
                        iconSize: Size(36, 36),
                        icon: controller.currentUser.value?.imageUrl == null
                            ? Icon(
                                FontAwesomeIcons.circleUser,
                                size: 36,
                              )
                            : SkeletonCircleAvatar(
                                url: controller.currentUser.value!.imageUrl!)),
                  ),
                  ProfileItem(
                    title: 'credit_card'.tr,
                    detail:
                        '${controller.creditCards.length}' + 'cards_link'.tr,
                    onPress: () => Get.toNamed(
                        RouteManager.PROFILE + RouteManager.CREDIT_CARD,
                        arguments: controller.creditCards),
                    hasSeperator: true,
                    icon: SizedBox(child: CommonWidget.svgImage('visa_purple')),
                  ),
                  ProfileItem(
                      title: 'address'.tr,
                      detail: 'add_new_or_remove_address'.tr,
                      hasSeperator: true,
                      icon:
                          SizedBox(child: CommonWidget.svgImage('ic_address'))),
                  ProfileItem(
                      title: 'notification'.tr,
                      onPress: () => Get.toNamed(RouteManager.NOTIFICATION),
                      hasSeperator: true,
                      icon: SizedBox(
                        child: CommonWidget.svgImage('ic_notification'),
                      )),
                  ProfileItem(
                      title: 'verifications'.tr,
                      hasSeperator: true,
                      icon: SizedBox(
                        child: CommonWidget.svgImage('ic_verification'),
                      )),
                  ProfileItem(
                      title: 'customer_support'.tr,
                      onPress: () =>
                          Get.toNamed(RouteManager.HOME_SUPPORT_SCREEN),
                      hasSeperator: true,
                      icon: SizedBox(
                          child: CommonWidget.svgImage('ic_customer_sp'))),
                  ProfileItem(
                      title: 'about_us'.tr,
                      hasSeperator: true,
                      icon: SizedBox(child: CommonWidget.svgImage('ic_about'))),
                  ProfileItem(
                      title: 'sign_out'.tr,
                      hasSeperator: true,
                      onPress: () => controller.signOut(),
                      icon:
                          SizedBox(child: CommonWidget.svgImage('ic_logout'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
