import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ResetPasswordController(apiRepository: Get.find()));
  }
}
