// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class TaskService {
  static Uri LIST_URI = Uri.parse('$baseURL/task/listByUser/');
  static Uri CREATE_URI = Uri.parse('$baseURL/task/create');
  static Uri FIND_BY_ID_URI = Uri.parse('$baseURL/task/find/');
  static Uri UPDATE_CONTENT_URI = Uri.parse('$baseURL/task/update/content/');
  static Uri RENAME_URI = Uri.parse('$baseURL/task/rename/');
  static Uri UPDATE_STATE_URI = Uri.parse('$baseURL/task/update/state/');
  static Uri DELETE_URI = Uri.parse('$baseURL/task/delete/');

  static Future<List<Task>?> list(PaginateParam paginateParam) async {
    print(1);
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(LIST_URI,
        headers: authHeader(token!), body: jsonEncode(paginateParam.toJson()));
    if (response.statusCode == 200) {
      var tasks = List<Task>.empty();
      var temp = CommonResp.fromJson(json.decode(response.body));
      if (temp.code == "SUCCESS") {
        var temp2 = temp.data! as List;
        tasks = (temp2.map((model) => Task.fromJson(model)).toList());
        return tasks;
      }
      return List.empty();
    } else {
      // throw Exception('Failed to load data!');
      return List.empty();
    }
  }

  static Future<CommonResp?> create(String newName, String newContent) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(Uri.parse('$baseURL/task/create'),
        headers: authHeader(token!),
        //TODO
        body: jsonEncode(<String, String>{"name": newName}));
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
    var response = await client.post(Uri.parse('$baseURL/prj/rename/$id'),
        headers: authHeader(token!), body: jsonEncode(newName));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }
}