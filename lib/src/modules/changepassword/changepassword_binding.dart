import 'package:get/get.dart';

import 'changepassword_controller.dart';
class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}