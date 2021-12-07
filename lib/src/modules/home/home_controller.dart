import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

class HomeController extends GetxController {
  var _recentTasks = <Task>[].obs;

  List<Task> get recentTask => _recentTasks.toList();

  @override
  void onInit() {
    _getRecenTask();
    super.onInit();
  }

  void _getRecenTask() async {
    String? ids =
        await getStringLocalStorge(LocalStorageKey.RECENT_TASK.toString());
    print(ids);
    if (ids != null) {
      var rs = ids.split("|");
      List<Task> tasks = List.empty(growable: true);
      for (String s in rs) {
        print(s);
        Task? task = await TaskService.find(int.parse(s));
        if (task != null) {
          tasks.add(task);
        }
      }
      _recentTasks.assignAll(tasks);
    }
  }

  void updateT() {
    _getRecenTask();
  }
}
