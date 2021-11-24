import 'package:mobile_app/src/data/models/user.dart';
import 'dart:convert';

class Task {
  late int? id;
  late String? content;
  late String? name;
  late String? visibleTaskScope;
  late String? priority;
  late String? taskState;
  late List? project;
  late List? userIdIfVisibleIsPrivate;

  Task(
      {required this.id,
      required this.content,
      required this.name,
      required this.visibleTaskScope,
      required this.priority,
      required this.taskState,
      required this.project,
      required this.userIdIfVisibleIsPrivate, userDTOSet});

  Task.name();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        content: json['content'],
        name: json['name'],
        visibleTaskScope: json['visibleTaskScope'],
        priority: json['priority'],
        taskState: json['taskState'],
        project: json['project'],
        userIdIfVisibleIsPrivate: json[""] == null
            ? null
            : (json["userDTOSet"] as List)
                .map((i) => User.fromJson(i))
                .toList());
    // return Project.name();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, name: $name}';
  }
}

