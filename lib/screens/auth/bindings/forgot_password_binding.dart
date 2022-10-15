import 'package:get/get.dart';

import '../controllers/controllers.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ForgotPasswordController(apiRepository: Get.find()));
  }
}
