import 'package:get/get.dart';

import '../controllers/resgister_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => RegisterController());
  }
}
