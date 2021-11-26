import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class User {
  late int id;
  late String email;
  late String? role;

  static Future<String?> getToken() async {
    return getStringLocalStorge(LocalStorageKey.TOKEN.toString());
  }

  User({required this.id, required this.email, required this.role});
  User.empty();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], email: json['email'], role: json['role']);
  }

  Map<String, dynamic> toJson() => {"id": id, "email": email};

  @override
  String toString() => 'User(id: $id, email: $email, role: $role)';
}
