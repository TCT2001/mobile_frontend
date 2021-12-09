import 'project.dart';

class Task {
  late int? id;
  late String? content;
  late String? name;
  late String? visibleTaskScope;
  late String? priority;
  late String? taskState;
  late String? deadline;
  late int? userIdIfVisibleIsPrivate;
  late String? briefContent;
  late String? role;
  late Project? project;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        visibleTaskScope: json['visibleTaskScope'],
        priority: json['priority'],
        taskState: json['taskState'],
        deadline: json['deadline'],
        briefContent: json['briefContent'],
        role: json['role'],
        userIdIfVisibleIsPrivate: json['userIdIfVisibleIsPrivate'],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]));
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
      required this.deadline,
      required this.userIdIfVisibleIsPrivate,
      userDTOSet,
      required this.briefContent,
      required this.role,
      required this.project});

  Task.name(this.id);

  @override
  int get hashCode => id.hashCode;

  // @override
  // String toString() {
  //   return 'Task{id: $id, name: $name}';
  // }

  // static Map<String, dynamic> toMap(Task task) => {
  //       'id': task.id,
  //       'name': task.name,
  //       'content': task.content,
  //       'visibleTaskScope': task.briefContent,
  //       'priority': task.priority,
  //       'taskState': task.taskState,
  //       'deadline': task.deadline,
  //       'briefContent': task.briefContent
  //     };

  // static List<Task> decode(String tasks) =>
  //     (json.decode(tasks) as List<dynamic>)
  //         .map<Task>((item) => Task.fromJson(item))
  //         .toList();

  // static String encode(List<Task> tasks) => json.encode(
  //       tasks.map<Map<String, dynamic>>((task) => Task.toMap(music)).toList(),
  //     );

  @override
  String toString() {
    return 'Task(id: $content)';
  }
}
