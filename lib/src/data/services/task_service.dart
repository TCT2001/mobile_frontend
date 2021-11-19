// ignore_for_file: non_constant_identifier_names

import 'package:mobile_app/src/core/utils/http.dart';

class TaskService {
  static Uri LIST_URI = Uri.parse('$baseURL/task/list/');
  static Uri CREATE_URI = Uri.parse('$baseURL/task/create');
  static Uri FIND_BY_ID_URI = Uri.parse('$baseURL/task/find/');
  static Uri UPDATE_CONTENT_URI = Uri.parse('$baseURL/task/update/content/');
  static Uri RENAME_URI = Uri.parse('$baseURL/task/rename/');
  static Uri UPDATE_STATE_URI = Uri.parse('$baseURL/task/update/state/');
  static Uri DELETE_URI = Uri.parse('$baseURL/task/delete/');
}