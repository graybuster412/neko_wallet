import 'package:get/get.dart';
import 'package:neko_wallet/screens/auth/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => LoginController());
  }
}
