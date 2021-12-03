// ignore_for_file: unnecessary_this

import 'package:get/get.dart';
import 'package:mobile_app/src/modules/task/task_user_controller.dart';

class MainLayoutController extends GetxController {
  final _index = 0.obs;
  get index => this._index.value;
  set index(value) => this._index.value = value;

  void changeIndex(int index) {
    this.index = index;
    if (index != 2) {
      Get.delete<TaskUserController>();
    } else {
      Get.put<TaskUserController>(TaskUserController());
    }
  }
}