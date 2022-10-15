import 'package:get/get.dart';

import '../../profile/controllers/controllers.dart';
import '../dash_board.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ProfileController());
    Get.lazyPut(() => DashBoardController());
  }
}
