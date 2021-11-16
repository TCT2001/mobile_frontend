import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/widgets_controller.dart';

class WidgetsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetsController>(() => WidgetsController());
  }
}
