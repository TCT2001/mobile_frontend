import 'package:get/get.dart';

import 'task_controller.dart';
class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}