// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/comment.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class TaskService {
  static Uri LIST_URI = Uri.parse('$baseURL/task/listByUser/');
  static Uri CREATE_URI = Uri.parse('$baseURL/task/create');
  static Uri FIND_BY_ID_URI = Uri.parse('$baseURL/task/find/');
  static Uri UPDATE_CONTENT_URI = Uri.parse('$baseURL/task/update/content/');
  static Uri RENAME_URI = Uri.parse('$baseURL/task/rename/'); //
  static Uri UPDATE_STATE_URI = Uri.parse('$baseURL/task/update/state/');
  static Uri DELETE_URI = Uri.parse('$baseURL/task/delete/'); //

  static Future<List<Task>?> list(PaginateParam paginateParam) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(LIST_URI,
        headers: authHeader(token!), body: jsonEncode(paginateParam.toJson()));
    if (response.statusCode == 200) {
      var task = List<Task>.empty();
      var temp = CommonResp.fromJson(json.decode(response.body));
      if (temp.code == "SUCCESS") {
        var temp2 = temp.data! as List;
        task = (temp2.map((model) => Task.fromJson(model)).toList());
        return task;
      }
      return List.empty();
    } else {
      // throw Exception('Failed to load data!');
      return List.empty();
    }
  }

  static Future<List<Task>?> listByUsers(PaginateParam paginateParam) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(Uri.parse('$baseURL/task/listByUser'),
        headers: authHeader(token!), body: jsonEncode(paginateParam.toJson()));
    if (response.statusCode == 200) {
      var task = List<Task>.empty();
      var temp = CommonResp.fromJson(json.decode(response.body));
      if (temp.code == "SUCCESS") {
        var temp2 = temp.data! as List;
        task = (temp2.map((model) => Task.fromJson(model)).toList());
        return task;
      }
      return List.empty();
    } else {
      // throw Exception('Failed to load data!');
      return List.empty();
    }
  }

  static Future<List<Task>?> listByProject(PaginateParam paginateParam,
      int projectId) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(
        Uri.parse('$baseURL/task/listByProject/$projectId'),
        headers: authHeader(token!),
        body: jsonEncode(paginateParam.toJson()));
    if (response.statusCode == 200) {
      var task = List<Task>.empty();
      var temp = CommonResp.fromJson(json.decode(response.body));
      if (temp.code == "SUCCESS") {
        var temp2 = temp.data! as List;
        task = (temp2.map((model) => Task.fromJson(model)).toList());
        return task;
      }
      return List.empty();
    } else {
      // throw Exception('Failed to load data!');
      return List.empty();
    }
  }

  static Future<CommonResp?> delete(Task task) async {
    int? id = task.id;
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.delete(Uri.parse('$baseURL/task/delete/$id'),
        headers: authHeader(token!));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> rename(Task task, String newName) async {
    int? id = task.id;
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.put(Uri.parse('$baseURL/task/rename/$id'),
        headers: authHeader(token!), body: jsonEncode(newName));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> create(String newName, String newContent,
      String newState, String newPriority, String deadline, int id) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(Uri.parse('$baseURL/task/create'),
        headers: authHeader(token!),
        body: jsonEncode(<String, String>{
          "name": newName,
          "content": newContent,
          "taskState": newState,
          "priority": newPriority,
          "deadline": deadline.toString(),
          "projectId": id.toString()
        }));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<Task?> find(int id) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.get(Uri.parse('$baseURL/task/find/$id'),
        headers: authHeader(token!));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      Map<String, dynamic> jso1 = temp.data as Map<String, dynamic>;
      return Task.fromJson(jso1);
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> updateState(Task task, String newState) async {
    int? id = task.id;
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.put(Uri.parse('$baseURL/task/update/state/$id'),
        headers: authHeader(token!), body: jsonEncode(newState));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> updatePriority(Task task,
      String newPriority) async {
    int? id = task.id;
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.put(
        Uri.parse('$baseURL/task/update/priority/$id'),
        headers: authHeader(token!),
        body: jsonEncode(newPriority));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> updateContent(Task task, String newContent) async {
    int? id = task.id;
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.put(
        Uri.parse('$baseURL/task/update/content/$id'),
        headers: authHeader(token!),
        body: jsonEncode(newContent));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> postComment(int taskId, int userId,
      String content) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(Uri.parse('$baseURL/task/comment/post'),
        headers: authHeader(token!),
        body: jsonEncode(<String, String>{
          "taskId": taskId.toString(),
          "doerId": userId.toString(),
          "content": content
        }));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<List<Comment>> listComment(int taskId) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.get(
        Uri.parse('$baseURL/task/comment/list?t=$taskId'),
        headers: authHeader(token!));
    var comments = List<Comment>.empty();
    var temp = CommonResp.fromJson(json.decode(response.body));
    print("dmm: \n $temp");
    var temp2 = temp.data! as List;
    print("temp2 : $temp2");
    comments = (temp2.map((model) => Comment.fromJson(model)).toList());
    print("comments : $comments");
    return comments;
  }
}
