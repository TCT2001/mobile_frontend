import 'package:get/get.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

class TaskController extends GetxController {
  var _tasks = <Task>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;

  var selectedScope = 1.obs;
  var selectedPriority= 1.obs;
  var selectedState = 1.obs;

  final newName = ''.obs;
  final newContent = ''.obs;

  List<Task> get tasks => _tasks.toList();

  int? get _page => _paginateParam.value.page;

  bool get isLastPage => _isLastPage.value;

  Future<CommonResp?> renameProject(Task task, String newName) async {
    var temp = await TaskService.rename(task, newName);
    if (temp!.code == "SUCCESS") {
      //TODO
      //_listProject();
      _tasks
          .firstWhere((element) => element.id == task.id)
          .name =
          newName;
      _tasks.refresh();
    }
    return temp;
  }

  void _listTask() async {
    final data = await TaskService.list(_paginateParam.value);
    if (data!.isEmpty) _isLastPage.value = true;
    _tasks.addAll(data);
  }

  void nextPage() {
    _paginateParam.value.page += 1;
    _listTask();
  }

  Future<CommonResp?> createTask(String newName,String newContent) async {
    var temp = await TaskService.create(newName, newContent);
    if (temp!.code == "SUCCESS") {
      Task task = Task.fromJson(temp.data! as Map<String, dynamic>);
      _tasks.insert(0, task);
      // _projects.value = List.empty();
    }
    return temp;
  }
}