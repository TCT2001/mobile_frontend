import 'package:get/get.dart';
import 'package:mobile_app/src/modules/example/example_controller.dart';

class ExampleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExampleController>(() => ExampleController());
  }
}
