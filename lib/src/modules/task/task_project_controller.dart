// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

class TaskProjectController extends GetxController {
  int projectId;

  TaskProjectController({required this.projectId});

  var _tasks = <Task>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;

  var selectedScope = "PUBLIC".obs;
  var selectedPriority = "NORMAL".obs;
  var selectedState = "SUBMITTED".obs;

  List<Task> get tasks => _tasks.toList();

  int? get _page => _paginateParam.value.page;

  bool get isLastPage => _isLastPage.value;

  @override
  void onInit() {
    ever(_paginateParam, (_) => listTask());
    _changeParam(PaginateParam(page: 0));
    super.onInit();
  }

  void listTask() async {
    final data =
    await TaskService.listByProject(_paginateParam.value, projectId);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _tasks.addAll(data);
    //_tasks.refresh();
  }

  void sort(String sortField, bool sortAsc) async {
    _tasks.assignAll([]);
    _paginateParam = PaginateParam(page: 0).obs;
    _paginateParam.value.sortField = sortField;
    _paginateParam.value.sortAscending = sortAsc;
    final data = await TaskService.listByProject(_paginateParam.value, projectId);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _tasks.assignAll(data);
  }

  void _changeParam(PaginateParam paginateParam) {
    _paginateParam.update((val) {
      val!.page = paginateParam.page;
      val.filter = paginateParam.filter;
      val.sortField = paginateParam.sortField;
      val.sortAscending = paginateParam.sortAscending;
    });
  }

  void nextPage() {
    _paginateParam.value.page += 1;
    listTask();
  }

  void searchByName(String name) async {
    _tasks.assignAll([]);
    _paginateParam = PaginateParam(page: 0).obs;
    _paginateParam.value.filter = "name~$name";
    final data =
    await TaskService.listByProject(_paginateParam.value, projectId);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _tasks.assignAll(data);
  }

  Future<CommonResp?> renameTask(Task task, String newName) async {
    var temp = await TaskService.rename(task, newName);
    if (temp!.code == "SUCCESS") {
      _tasks.firstWhere((element) => element.id == task.id).name =
          _tasks.firstWhere((element) => element.id == task.id).name = newName;
      _tasks.refresh();
    }
    return temp;
  }

  Future<bool> deleteTask(Task task) async {
    var temp = await TaskService.delete(task);
    if (temp!.code == "SUCCESS") {
      _tasks.removeWhere((element) => element.id == task.id);
      //_tasks.refresh();
      return true;
    }
    return false;
  }

  Future<Task> find(int id) async {
    var temp = await TaskService.find(id);
    return temp!;
  }

  Future<CommonResp?> createTask(
      String newName, String newContent, String newState, String newPriority, String deadline, int? id) async {
    var temp = await TaskService.create(newName, newContent, newState, newPriority, deadline, id!);
    if (temp!.code == "SUCCESS") {
      Task task = Task.fromJson(temp.data! as Map<String, dynamic>);
      _tasks.insert(0, task);
      // _projects.value = List.empty();
      _tasks.refresh();
    }
    return temp;
  }

  Future<CommonResp?> updateState(Task task, String newState) async {
    var temp = await TaskService.updateState(task, newState);
    if (temp!.code == "SUCCESS") {
      _tasks.firstWhere((element) => element.id == task.id).taskState =
          newState;
      _tasks.refresh();
    }
    return temp;
  }

  Future<CommonResp?> updatePriority(Task task, String newPriority) async {
    var temp = await TaskService.updatePriority(task, newPriority);
    if (temp!.code == "SUCCESS") {
      _tasks.firstWhere((element) => element.id == task.id).priority =
          newPriority;
      _tasks.refresh();
    }
    return temp;
  }

  Future<CommonResp?> updateContent(Task task, String newContent) async {
    var temp = await TaskService.updateContent(task, newContent);
    if (temp!.code == "SUCCESS") {
      //TODO
      //_listProject();
      _tasks.firstWhere((element) => element.id == task.id).content =
          newContent;
      _tasks.refresh();
    }
    return temp;
  }
}
