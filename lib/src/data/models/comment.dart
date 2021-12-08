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
    print(json["userDTO"]);
    return Comment(
        id: json['id'],
        userDTO: User.fromJson(json["userDTO"]),
        taskId: json['taskId'],
        content: json['content'],
        createdTime: json['createdTime']);
    // return Project.name();
  }
  // factory Comment.fromJson(Map<String, dynamic> map) {
  //   return Comment(
  //       id: map['id'],
  //       userDTO: map["userDTO"],
  //       taskId: map['taskId'],
  //       content: map['content'],
  //       createdTime: map['createdTime']);
  // }

  // factory Comment.fromJson(Map<String, dynamic> map) {
  //   return Comment(
  //       id: map['id'],
  //       userDTO: map["userDTO"] == null
  //                 ? null
  //                 : (map["userDTO"] as List)
  //                 .map((i) => User.fromJson(i))
  //                 .toList(),
  //       taskId: map['taskId'],
  //       content: map['content'],
  //       createdTime: map['createdTime']);
  //   )
  //}
}