import 'package:get/get.dart';
import 'package:mobile_app/src/modules/project/project_controller.dart';

class ProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProjectController());
  }
}