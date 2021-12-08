import 'package:mobile_app/src/data/models/user.dart';

class Comment {
  late int? id;
  late User? userDTO;
  late int? taskId;
  late String? content;
  late String? createdTime;

  Comment(
      {required this.id,
        required this.userDTO,
        required this.taskId,
        required this.content,
        required this.createdTime});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        userDTO: User.fromJson(json["userDTO"]),
        taskId: json['taskId'],
        content: json['content'],
        createdTime: json['createdTime']);
  }
}