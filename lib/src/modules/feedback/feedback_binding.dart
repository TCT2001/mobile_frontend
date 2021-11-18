import 'package:get/get.dart';
import 'package:mobile_app/src/modules/feedback/feedback_controller.dart';

class FeedbackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }
}
