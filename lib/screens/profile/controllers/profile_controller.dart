import 'package:get/get.dart';
import 'package:neko_wallet/models/models.dart';

import '../../auth/auth.dart';

class ProfileController extends GetxController {
  Rx<UserModel?> currentUser = null.obs;

  final AuthController _authController = Get.find();

  RxList<CreditCardViewModel> creditCards = [
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
        expiredDate: DateTime.now().toString()),
    CreditCardViewModel(
        cardHolder: 'Kelvin Pham',
        cardNumber: '1234125672341234',
        type: 'visa',
        currency: '1234',
        currencyType: 'US',
        expiredDate: DateTime.now().toString())
  ].obs;

  signOut() {
    _authController.signOut();
  }

  @override
  void onInit() {
    currentUser.value = _authController.user.value;
    super.onInit();
  }
}
