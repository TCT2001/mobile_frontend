// ignore_for_file: prefer_if_null_operators

import 'package:mobile_app/src/data/models/user.dart';

class Project {
  late int? id;
  late String? name;
  late List? userDTOSet;
  late String? role;
  Project.nonRole(
      {required this.id, required this.name, required this.userDTOSet});

  Project(
      {required this.id,
      required this.name,
      required this.role,
      required this.userDTOSet});
  Project.name();
  Project.id({required this.id});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        userDTOSet: json["userDTOSet"] == null
            ? null
            : (json["userDTOSet"] as List)
                .map((i) => User.fromJson(i))
                .toList());
    // return Project.name();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Project(id: $id, name: $name, userDTOSet: $userDTOSet)';
}
