import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'project.dart';
class Task{
  late int? id;
  late String? name;
  late String? content;
  late String? visibleTaskScope;
  late String? priority;
  late String? taskState;
  // late List? project;
  late int? userIdIfVisibleIsPrivate;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        visibleTaskScope: json['visibleTaskScope'],
        priority: json['priority'],
        taskState: json['taskState'],
        // project: json['project'] == null
        //     ?null
        //     :(json['project'] as List)
        //     .map((i) => Project.fromJson(i))
        //     .toList(),
        userIdIfVisibleIsPrivate: json['userIdIfVisibleIsPrivate']);
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Task &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;
  Task(
      {required this.id,
        required this.name,
        required this.content,
        required this.visibleTaskScope,
        required this.priority,
        required this.taskState,
        //required this.project,
        required this.userIdIfVisibleIsPrivate, userDTOSet});
  Task.name();

  @override
  int get hashCode => id.hashCode;
  @override
  String toString() {
    return 'Task{id: $id, name: $name}';
  }

}