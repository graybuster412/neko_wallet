import 'package:get/get.dart';
import 'package:neko_wallet/models/notification_model.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../../widgets/list_item/notification_list_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen();

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> _notifications = [
    NotificationModel(
        title: '',
        content:
            'Scarlett sent money to you \$125 or your monthly student payment',
        type: NotificationType.share,
        isChecked: true),
    NotificationModel(
        title: '',
        content:
            'Scarlett sent money to you \$125 or your monthly student payment',
        type: NotificationType.income,
        isChecked: true),
  ];

  List<NotificationModel> _oldNotifications = [
    NotificationModel(
        title: '',
        content:
            'Scarlett sent money to you \$125 or your monthly student payment',
        type: NotificationType.expense),
    NotificationModel(
        title: '',
        content:
            'Scarlett sent money to you \$125 or your monthly student payment',
        type: NotificationType.income),
    NotificationModel(
        title: '',
        content:
            'Scarlett sent money to you \$125 or your monthly student payment',
        type: NotificationType.share),
    NotificationModel(
        title: '',
        content:
            'Scarlett sent money to you \$125 or your monthly student payment',
        type: NotificationType.payment),
  ];

  Widget _buildListItem(int index, NotificationModel notification) {
    return NotificationListItem(
        notificationModel: notification, onPress: _onPressNotifcation);
  }

  _onPressNotifcation(NotificationModel notificationModel) {}

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderGradient(
                title: 'notification'.tr,
                isCurved: false,
                gradient: makeLinearGradient(colors: AppColors.primaryGradientColors),
                leftIcon: AppSvgs.backWhite,
                onPressLeftIcon: () => Navigator.of(context).pop(),
                iconSize: 36,
                padding: EdgeInsets.only(
                  left: 22.0,
                  top: MediaQuery.of(context).padding.top > 20
                      ? isAndroid()
                          ? MediaQuery.of(context).padding.top + 30
                          : MediaQuery.of(context).padding.top + 15
                      : MediaQuery.of(context).padding.top + 30,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: StyleText(
                  text: 'recent'.tr,
                  textColor: AppColors.gray2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  scrollDirection: Axis.vertical,
                  itemCount: _notifications.length,
                  itemBuilder: (context, int index) =>
                      _buildListItem(index, _notifications[index])),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: StyleText(
                  text: 'older_notification'.tr,
                  textColor: AppColors.gray2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _oldNotifications.length,
                    itemBuilder: (context, int index) =>
                        _buildListItem(index, _oldNotifications[index])),
              )
            ]);
      }),
    );
  }
}
