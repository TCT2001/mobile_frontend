import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

// class TaskController extends GetxController {
//   var _task = <Task>[].obs;
//   var _paginateParam = PaginateParam(page: 0).obs;
//   var _isLastPage = false.obs;
//   var _choice = 0.obs;
//   var _clickedTaskCard = Task(id: -1, name: "-1", userDTOSet: null, content: 'null', taskState: '', priority: '', project: [], visibleTaskScope: '', userIdIfVisibleIsPrivate: [], ).obs;
//
//   final newName = ''.obs;
//
//   List<Task> get task => _task.toList();
//
//   Task get clickedTaskCard => _clickedTaskCard.value;
//
//   int? get _page => _paginateParam.value.page;
//
//   bool get isLastPage => _isLastPage.value;
//
//   int get choice => _choice.value;
//
//   @override
//   void onInit() {
//     ever(_paginateParam, (_) => _listTask());
//     _changeParam(PaginateParam(page: 0));
//     super.onInit();
//   }
//
//   void changeChoice(int arg, Task? task) {
//     _choice.value = arg;
//     if (task != null) {
//       _clickedTaskCard.value.id = task.id;
//       _clickedTaskCard.value.name = task.name;
//     }
//   }
//
//   void _listTask() async {
//     final data = await TaskService.list(_paginateParam.value);
//     if (data!.isEmpty) _isLastPage.value = true;
//     _task.addAll(data);
//   }
//
//   void _changeParam(PaginateParam paginateParam) {
//     _paginateParam.update((val) {
//       val!.page = paginateParam.page;
//       val.filter = paginateParam.filter;
//       val.sortField = paginateParam.sortField;
//       val.sortAscending = paginateParam.sortAscending;
//     });
//   }
//
//   void nextPage() {
//     _paginateParam.value.page += 1;
//     _listTask();
//   }
//
//   Future<bool> deleteTask(Task task) async {
//     var temp = await TaskService.delete(task);
//     if (temp!.code == "SUCCESS") {
//       _task.removeWhere((element) => element.id == task.id);
//       //_task.refresh();
//       return true;
//     }
//     return false;
//   }
//
//   Future<CommonResp?> renameTask(Task task, String newName) async {
//     var temp = await TaskService.rename(task, newName);
//     if (temp!.code == "SUCCESS") {
//       //TODO
//       //_listTask();
//       _task.firstWhere((element) => element.id == task.id).name =
//           newName;
//       _task.refresh();
//     }
//     return temp;
//   }
//
//   Future<CommonResp?> createTask(String newName) async {
//     var temp = await TaskService.create(newName);
//     if (temp!.code == "SUCCESS") {
//       Task task = Task.fromJson(temp.data! as Map<String, dynamic>);
//       _task.insert(0, task);
//       // _task.value = List.empty();
//     }
//     return temp;
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
class TaskController extends GetxController {
  var _tasks = <Task>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;

  var selectedScope = 1.obs;
  var selectedPriority = 1.obs;
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
      _tasks.firstWhere((element) => element.id == task.id).name = newName;
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

  Future<CommonResp?> createTask(String newName, String newContent) async {
    var temp = await TaskService.create(newName);
    if (temp!.code == "SUCCESS") {
      Task task = Task.fromJson(temp.data! as Map<String, dynamic>);
      _tasks.insert(0, task);
      // _projects.value = List.empty();
    }
    return temp;
  }
}
