import 'package:mobile_app/src/data/models/user.dart';

class Project {
  late int id;
  late String name;
  late List? userDTOSet;
  Project({required this.id, required this.name, required this.userDTOSet});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        name: json['name'],
        userDTOSet: json["userDTOSet"] == null
            ? null
            : (json["userDTOSet"] as List)
                .map((i) => User.fromJson(i))
                .toList());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
