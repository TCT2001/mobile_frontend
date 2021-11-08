import 'package:get/get.dart';
import 'package:mobile_app/src/modules/home/home_controller.dart';

import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}