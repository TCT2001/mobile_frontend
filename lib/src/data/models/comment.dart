import 'package:mobile_app/src/data/models/user.dart';

class Comment {
  late int? id;
  late List? userDTOSet;
  late int? taskId;
  late String? content;

  Comment(
      {required this.id,
        required this.userDTOSet,
        required this.taskId,
        required this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        userDTOSet: json["userDTOSet"] == null
            ? null
            : (json["userDTOSet"] as List)
            .map((i) => User.fromJson(i))
            .toList(),
        taskId: json['taskId'],
        content: json['content']);
    // return Project.name();
  }
}