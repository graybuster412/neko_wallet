import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:neko_wallet/screens/auth/controllers/auth_controller.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/utils/utils.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:neko_wallet/widgets/header_gradient.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/profile/skeleton_circle_avatar.dart';
import 'package:neko_wallet/widgets/profile/input_edit_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;

  final AuthController _authController = Get.find();

  _onPressEditAvatar() {}

  _onPressSave() {}

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isLoading: _isLoading,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray4,
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                HeaderGradient(
                  title: 'edit_profile'.tr,
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
                SizedBox(height: 11),
                Column(children: [
                  Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Stack(children: [
                        GestureDetector(
                          onTap: _onPressEditAvatar,
                          child: Container(
                            height: 80,
                            width: 80,
                            child: _authController.user.value.imageUrl == null
                                ? Icon(
                                    FontAwesomeIcons.circleUser,
                                    size: 80,
                                    color: Colors.white,
                                  )
                                : SkeletonCircleAvatar(
                                    url: _authController.user.value.imageUrl!),
                          ),
                        ),
                        Positioned(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 15.0,
                                color: Color(0xFF404040),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(height: 1, color: AppColors.seperator),
                  Obx(
                    () => InputEditProfile(
                      title: 'email'.tr,
                      placeholder: 'your_email'.tr,
                      value: _authController.user.value.email,
                      returnKeyboardType: TextInputAction.next,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                      isEditable: false,
                      onChangeText: (text) {},
                    ),
                  ),
                  Obx(
                    () => InputEditProfile(
                      title: 'username'.tr,
                      placeholder: 'your_name'.tr,
                      value: _authController.user.value.name,
                      returnKeyboardType: TextInputAction.next,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      onChangeText: (text) {},
                    ),
                  ),
                  InputEditProfile(
                    title: 'date_of_birth'.tr,
                    placeholder: 'date_of_birth'.tr,
                    value: '04/01/1992',
                    returnKeyboardType: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    onChangeText: (text) {},
                  ),
                  Obx(
                    () => InputEditProfile(
                      title: 'gender'.tr,
                      useDropdown: true,
                      value: _authController.user.value.gender ?? 'Male',
                      returnKeyboardType: TextInputAction.next,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      onChangeText: (gender) {
                        _authController.user.value.gender = gender;
                        _authController.onChangeUser(_authController.user);
                      },
                    ),
                  ),
                  // Obx(
                  //   () => InputEditProfile(
                  //     title: 'Phone',
                  //     placeholder: 'Your phone number',
                  //     value: _authController.user.value.phoneNumber,
                  //     returnKeyboardType: TextInputAction.done,
                  //     keyboardType: TextInputType.phone,
                  //     padding: EdgeInsets.only(left: 20, right: 20),
                  //     onChangeText: (text) {
                  //       print(text);
                  //     },
                  //   ),
                  // ),
                ]),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ButtonCT(
                      title: "save".tr,
                      isLoading: _isLoading,
                      buttonStyle: ButtonCTStyle(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        buttonColor: Colors.white,
                        titleColor: Colors.white,
                        borderColor: Colors.transparent,
                        gradient: LinearGradient(
                            begin: Alignment(-1.0, -1),
                            end: Alignment(-1.0, 1),
                            colors: AppColors.primaryGradientColors,
                            tileMode: TileMode.clamp),
                      ),
                      onPressButton: _onPressSave),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20)
              ],
            ),
          ),
        );
      }),
    );
  }
}
