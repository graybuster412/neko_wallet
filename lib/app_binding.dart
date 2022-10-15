import 'package:get/get.dart';

import 'app_controller.dart';
import 'data/api/api.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AppController(), permanent: true);
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find()), permanent: true);
  }
}
