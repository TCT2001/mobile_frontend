import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_app/src/data/models/comment.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/services/task_service.dart';

class CommentController extends GetxController{
  int taskId;

  CommentController({required this.taskId});

  var _comments = <Comment>[].obs;
  var _paginateParam = PaginateParam(page: 0).obs;
  var _isLastPage = false.obs;

  bool get isLastPage => _isLastPage.value;

  List<Comment> get comments => _comments.toList();

  @override
  void onInit() {
    ever(_paginateParam, (_) => listComment());
    super.onInit();
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

  void nextPage() {
    _paginateParam.value.page += 1;
    listComment();
  }

  void listComment() async {
    final data =
    await TaskService.listComment(taskId);
    if (data!.isEmpty) {
      _isLastPage.value = true;
      return;
    }
    _comments.addAll(data);
    //_tasks.refresh();
  }
}