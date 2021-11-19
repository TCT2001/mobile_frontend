import 'package:shared_preferences/shared_preferences.dart';

class User {
  late int id;
  late String email;

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  User({required this.id, required this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: int.parse(json['id']), email: json['username']);

  Map<String, dynamic> toJson() => {"id": id, "username": email};
}
