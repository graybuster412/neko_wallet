import 'package:flutter/material.dart';
import 'package:neko_wallet/models/notification_model.dart';

import '../../shared/shared.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem(
      {Key? key, required this.notificationModel, this.onPress})
      : super(key: key);

  @required
  final NotificationModel notificationModel;

  @required
  final ValueChanged<NotificationModel>? onPress;

  Widget _getIcon() {
    switch (notificationModel.type) {
      case NotificationType.income:
        return SizedBox(
            child: CommonWidget.svgImage('ic_new_income'),
            width: 34,
            height: 34);
      case NotificationType.expense:
        return SizedBox(
            child: CommonWidget.svgImage('ic_new_expense'),
            width: 34,
            height: 34);
      case NotificationType.share:
        return SizedBox(
            child: CommonWidget.svgImage('ic_share'), width: 34, height: 34);
      case NotificationType.payment:
        return SizedBox(
            child: CommonWidget.svgImage('ic_invoice_payment'),
            width: 34,
            height: 34);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        containedInkWell: true,
        onTap: () => onPress != null ? onPress!(this.notificationModel) : () {},
        child: Container(
          height: 74,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: notificationModel.isChecked
              ? AppColors.white1
              : AppColors.transparent,
          child: Row(
            children: [
              _getIcon(),
              SizedBox(width: 20),
              Flexible(
                child: RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: AppColors.text,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: '${notificationModel.getFirstWord()}',
                          style: TextStyle(
                              color: AppColors.blue1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins')),
                      new TextSpan(
                          text: ' ${notificationModel.getRestOfContent()}',
                          style: TextStyle(
                              color: AppColors.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
