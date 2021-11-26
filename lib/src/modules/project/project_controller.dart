// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/services/project_service.dart';

class ProjectController extends GetxController {
  var _projects = <Project>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;

  final newName = ''.obs;

  List<Project> get projects => _projects.toList();

  int? get _page => _paginateParam.value.page;

  bool get isLastPage => _isLastPage.value;

  @override
  void onInit() {
    ever(_paginateParam, (_) => _listProject());
    _changeParam(PaginateParam(page: 0));
    super.onInit();
  }

  void _listProject() async {
    final data = await ProjectService.list(_paginateParam.value);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _projects.addAll(data);
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
    _listProject();
  }

  Future<bool> deleteProject(Project project) async {
    var temp = await ProjectService.delete(project);
    if (temp!.code == "SUCCESS") {
      _projects.removeWhere((element) => element.id == project.id);
      //_projects.refresh();
      return true;
    }
    return false;
  }

  Future<CommonResp?> renameProject(Project project, String newName) async {
    var temp = await ProjectService.rename(project, newName);
    if (temp!.code == "SUCCESS") {
      //TODO
      //_listProject();
      _projects.firstWhere((element) => element.id == project.id).name =
          newName;
      _projects.refresh();
    }
    return temp;
  }

  Future<CommonResp?> createProject(String newName) async {
    var temp = await ProjectService.create(newName);
    if (temp!.code == "SUCCESS") {
      Project project = Project.fromJson(temp.data! as Map<String, dynamic>);
      _projects.insert(0, project);
      // _projects.value = List.empty()
    }
    return temp;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
