import 'package:get/get.dart';
import 'package:mobile_app/src/modules/init/init_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitController>(() => InitController());
  }
}
