import 'package:get/get.dart';

import 'repassword_controller.dart';
class RePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RePasswordController>(() => RePasswordController());
  }
}