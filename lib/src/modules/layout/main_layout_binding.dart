import 'package:get/get.dart';
import 'package:mobile_app/src/modules/home/home_controller.dart';

import 'main_layout_controller.dart';

class MainLayoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
  }
}
