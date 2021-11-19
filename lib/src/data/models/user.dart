import 'package:shared_preferences/shared_preferences.dart';

class User {
  late int id;
  late String email;
  late String? role;

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  User({required this.id, required this.email, required this.role});
  User.empty();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], email: json['email'], role: json['role']);
  }

  Map<String, dynamic> toJson() => {"id": id, "email": email};
}
