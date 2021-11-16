import 'package:get/get.dart';
import 'package:mobile_app/src/modules/neo/neo_controller.dart';

class NeoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NeoController>(() => NeoController());
  }
}
