import 'package:get/get.dart';

import 'main_layout_controller.dart';

class MainLayoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
  }
}
