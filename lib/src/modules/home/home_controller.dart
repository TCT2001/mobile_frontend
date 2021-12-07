import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class HomeController extends GetxController {
  var _recentTasks = <Task>[].obs;

  List<Task> get recentTask => _recentTasks.toList();

  @override
  void onInit() {
    _getRecenTask();
    super.onInit();
  }

  void _getRecenTask() async {}
}
