import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/data/models/project.dart';

class Task{
  late int? id;
  late String? name;
  late String? content;
  late String? visibleTaskScope;
  late String? priority;
  late String? taskState;
  late List? project;
  late int? userIdIfVisibleIsPrivate;
  Task({required this.id, required this.name, required this.content,required this.visibleTaskScope, required this.priority,required this.taskState,required this.project,required this.userIdIfVisibleIsPrivate});
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        visibleTaskScope: json['visibleTaskScope'],
        priority: json['priority'],
        taskState: json['taskState'],
        project: json['project'] == null
          ?null
          :(json['project'] as List)
            .map((i) => Project.fromJson(i))
            .toList(),
        userIdIfVisibleIsPrivate: json['userIdIfVisibleIsPrivate']);
  }
}