// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile_app/src/data/models/comment.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile_app/src/data/models/comment.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

class TaskUserController extends GetxController {
  var _tasks = <Task>[].obs;
  var _comments = <Comment>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;

  var selectedScope = "PUBLIC".obs;
  var selectedPriority = "NORMAL".obs;
  var selectedState = "SUBMITTED".obs;
  //var projectId = 0.obs;

  List<Task> get tasks => _tasks.toList();

  // List<Task> get tasksOfProject => _tasksOfProject.toList();

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
    await TaskService.listByUsers(_paginateParam.value);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _tasks.addAll(data);
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
    //TODO TODO
    _paginateParam.value.filter = "briefContent~$name";
    final data = await TaskService.listByUsers(_paginateParam.value);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _tasks.assignAll(data);
    // _listProject();
    // _projects.;
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

  void sort(String sortField, bool sortAsc) async {
    _tasks.assignAll([]);
    _paginateParam = PaginateParam(page: 0).obs;
    _paginateParam.value.sortField = sortField;
    _paginateParam.value.sortAscending = sortAsc;
    final data = await TaskService.listByUsers(_paginateParam.value);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _tasks.assignAll(data);
  }

  Future<Task> find(int id) async {
    var temp = await TaskService.find(id);
    return temp!;
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
      _tasks.firstWhere((element) => element.id == task.id).content =
          newContent;
      _tasks.refresh();
    }
    return temp;
  }

  Future<CommonResp?> postComment(
      int taskId, int userId, String content) async {
    var temp = await TaskService.postComment(taskId, userId, content);
    if (temp!.code == "SUCCESS") {
      Comment comment = Comment.fromJson(temp.data! as Map<String, dynamic>);
      _comments.insert(0, comment);
      // _projects.value = List.empty();
      _comments.refresh();
    }
    return temp;
  }

  @override
  void onClose() {
    super.onClose();
  }
}