import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/services/project_service.dart';

class ProjectController extends GetxController {
  final _projects = <Project>[].obs;
  final _paginateParam = PaginateParam(page: 0).obs;
  final _isLastPage = false.obs;

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
    if (data!.isEmpty) _isLastPage.value = true;
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
  }

  Future<void> deleteProject(Project project) async {
    var temp = await ProjectService.delete(project);
    if (temp!.code == "SUCCESS") {
      _projects.removeWhere((element) => element.id == project.id);
    }
  }
}
