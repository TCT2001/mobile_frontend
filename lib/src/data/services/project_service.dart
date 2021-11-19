// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/models/paginate_param.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';

class ProjectService {
  static Uri LIST_URI = Uri.parse('$baseURL/prj/list');
  static Uri CREATE_URI = Uri.parse('$baseURL/prj/create');
  static Uri LIST_USER_URI = Uri.parse('$baseURL/prj/listUsersInProject/');
  static Uri FIND_BY_ID = Uri.parse('$baseURL/prj/find/{id}');
  static Uri RENAME_URI = Uri.parse('$baseURL/prj/rename/');
  static Uri DELETE_URI = Uri.parse('$baseURL/prj/delete/');

  static Future<List<Project>?> list(PaginateParam paginateParam) async {
    var response = await client.post(LIST_URI,
        headers: authHeader,
        body: jsonEncode(paginateParam.toJson()));
    if (response.statusCode == 200) {
      var projects = List<Project>.empty();
      var temp = CommonResp.fromJson(json.decode(response.body));
      if (temp.code == "SUCCESS") {
        projects = temp.data!.map((model) => Project.fromJson(model)).toList();
        return projects;
      }
      return List.empty();
    } else {
      // throw Exception('Failed to load data!');
      return List.empty();
    }
  }

  static Future<CommonResp?> delete(Project project) async {
    int? id = project.id;
    var response = await client.delete(
        Uri.parse('$baseURL/prj/delete/$id'),
        headers: authHeader);
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }
}
