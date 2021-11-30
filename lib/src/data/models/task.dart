import 'project.dart';

class Task {
  late int? id;
  late String? content;
  late String? name;
  late String? visibleTaskScope;
  late String? priority;
  late String? taskState;
  late int? userIdIfVisibleIsPrivate;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        visibleTaskScope: json['visibleTaskScope'],
        priority: json['priority'],
        taskState: json['taskState'],
        userIdIfVisibleIsPrivate: json['userIdIfVisibleIsPrivate']);
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Project &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  Task(
      {required this.id,
      required this.content,
      required this.name,
      required this.visibleTaskScope,
      required this.priority,
      required this.taskState,
      required this.userIdIfVisibleIsPrivate, userDTOSet});

  Task.name();


  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, name: $name}';
  }
}
