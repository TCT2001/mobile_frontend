import 'package:get/get.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

class TaskController extends GetxController {
  var _tasks = <Task>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;
  var _choice = 0.obs;
  var _clickedTaskCard = Task(id: -1, content: "", name: "-1", priority:"", taskState:"", project: null, userIdIfVisibleIsPrivate: null, userDTOSet: null, visibleTaskScope: '').obs;
  var selectedScope = 1.obs;
  var selectedPriority= 1.obs;
  var selectedState = 1.obs;

  final newName = ''.obs;
  final newContent = ''.obs;

  List<Task> get tasks => _tasks.toList();

  int? get _page => _paginateParam.value.page;

  Task get clickedProjectCard => _clickedTaskCard.value;

  bool get isLastPage => _isLastPage.value;


  void onInit() {
    ever(_paginateParam, (_) => _listTask());
    _changeParam(PaginateParam(page: 0));
    super.onInit();
  }

  void _changeParam(PaginateParam paginateParam) {
    _paginateParam.update((val) {
      val!.page = paginateParam.page;
      val.filter = paginateParam.filter;
      val.sortField = paginateParam.sortField;
      val.sortAscending = paginateParam.sortAscending;
    });
  }


  void changeChoice(int arg, Task? task) {
    _choice.value = arg;
    if (task != null) {
      _clickedTaskCard.value.id = task.id;
      _clickedTaskCard.value.name = task.name;
    }
  }

  Future<CommonResp?> renameTask(Task task, String newName) async {
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

  Future<bool> deleteProject(Task task) async {
    var temp = await TaskService.delete(task);
    if (temp!.code == "SUCCESS") {
      _tasks.removeWhere((element) => element.id == task.id);
      //_projects.refresh();
      return true;
    }
    return false;
  }


  Future<CommonResp?> findTask(Task task, String newName) async {
    var temp = await TaskService.find(newName);
    if (temp!.code == "SUCCESS") {
      //TODO
      //_listProject();
      _tasks
          .firstWhere((element) => element.id == task.id)
         ;
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

  Future<CommonResp?> createTask(String newName, String newContent, String newPriority, String newTaskState, String newVisibleTaskScope, Project? projectClicked, List<int> userIdIfVisibleIsPrivate ) async {
    var temp = await TaskService.create(newName, newContent, newPriority, newTaskState, newVisibleTaskScope, projectClicked, userIdIfVisibleIsPrivate);
    print(temp!.code);
    if (temp!.code == "SUCCESS") {
      Task task = Task.fromJson(temp.data! as Map<String, dynamic>);
      _tasks.insert(0, task);
      // _projects.value = List.empty();
    }
    return temp;
  }

  @override
  void onClose() {
    super.onClose();
  }

}