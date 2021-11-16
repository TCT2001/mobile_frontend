import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import 'noti_controller.dart';

class NotiBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotiController>(() => NotiController());
  }
}