// ignore_for_file: unnecessary_null_in_if_null_operators

class Invitation {
  int? id;
  String? srcEmail;
  String? desEmail;
  int? projectId;
  String? role;
  String? projectName;

  Invitation({
    this.id,
    this.srcEmail,
    this.desEmail,
    this.projectId,
    this.role,
    this.projectName
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'],
      srcEmail: json['src_email'],
      desEmail: json['des_email'],
      role: json['role'],
      projectId: json['object_id'],
      projectName: json['object_name'],
    );
  }


  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'srcEmail': srcEmail,
  //     'desEmail': desEmail,
  //     'projectId': projectId,
  //     'role': role,
  //     'projectName': projectName,
  //   };
  // }

  factory Invitation.fromMap(Map<String, dynamic> map) {
    return Invitation(
      id: map['id'] ?? null,
      srcEmail: map['src_email'] ?? null,
      desEmail: map['des_email'] ?? null,
      projectId: map['object_id'] ?? null,
      role: map['role'] ?? null,
      projectName: map['object_name'] ?? null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Invitation.fromJson(String source) => Invitation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'You have an invitation to join $projectName from $srcEmail';
  }
}
