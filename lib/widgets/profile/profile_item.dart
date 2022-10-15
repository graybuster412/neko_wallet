import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/progress_view.dart';

import '../../shared/shared.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem(
      {Key? key,
      required this.title,
      this.detail,
      this.editProfile: false,
      this.progress,
      this.icon,
      this.disabled: false,
      this.onPressEditProfile,
      this.hasSeperator: false,
      this.isBoldTitle: false,
      this.iconSize: const Size(35, 35),
      this.onPress})
      : super(key: key);

  final Widget? icon;

  final String title;

  final String? detail;

  final bool editProfile;

  final bool disabled;

  final bool hasSeperator;

  final bool isBoldTitle;

  final double? progress;

  final Size iconSize;

  final VoidCallback? onPress;

  final VoidCallback? onPressEditProfile;

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        splashColor: this.widget.disabled ? Colors.transparent : null,
        highlightColor: this.widget.disabled ? Colors.transparent : null,
        containedInkWell: true,
        onTap: () =>
            this.widget.onPress != null ? this.widget.onPress!() : () {},
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: this.widget.iconSize.width,
                          width: this.widget.iconSize.height,
                          child: this.widget.icon,
                        ),
                        SizedBox(width: 20),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.0),
                              StyleText(
                                text: this.widget.title,
                                fontSize: 14,
                                fontWeight: this.widget.isBoldTitle
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                textColor: HexColor.fromHex('#353333'),
                              ),
                              SizedBox(height: 5.0),
                              this.widget.detail != null
                                  ? StyleText(
                                      text: this.widget.detail!,
                                      fontSize: 14,
                                      textColor: HexColor.fromHex('#AFAFAF'),
                                    )
                                  : Container(),
                              this.widget.progress != null
                                  ? ProgressView(
                                      size: Size(130, 4),
                                      propress: this.widget.progress!,
                                      progressColor: makeLinearGradient(
                                          colors:
                                              AppColors.primaryGradientColors))
                                  : Container(),
                            ]),
                      ],
                    ),
                    this.widget.editProfile
                        ? Material(
                            color: Colors.transparent,
                            child: InkResponse(
                              onTap: this.widget.onPressEditProfile,
                              child: Text('Edit profile',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    color: HexColor.fromHex('#C4C2CB'),
                                  )),
                            ))
                        : Container(),
                  ],
                ),
              ),
              this.widget.hasSeperator
                  ? Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor.fromHex('#F6F6F6'),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
