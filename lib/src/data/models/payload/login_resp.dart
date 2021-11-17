// To parse this JSON data, do
//
//     final loginResp = loginRespFromJson(jsonString);

import 'dart:convert';

LoginResp loginRespFromJson(String str) {
  return LoginResp.fromJson(json.decode(str));
}

String loginRespToJson(LoginResp data) => json.encode(data.toJson());

class LoginResp {
  LoginResp({
    required this.code,
    this.loginRespData,
  });

  String code;
  LoginRespData? loginRespData;

  factory LoginResp.fromJson(Map<String, dynamic> json) => LoginResp(
        code: json["code"],
        loginRespData: LoginRespData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {"code": code, "data": json.encode(loginRespData!.toJson())};
}

class LoginRespData {
  late String token;
  late num id;
  late String refreshToken;
  late String username;

  LoginRespData.empty();

  LoginRespData(
      {required this.token,
      required this.id,
      required this.refreshToken,
      required this.username});

  factory LoginRespData.fromJson(Map<String, dynamic> json) => LoginRespData(
        token: json["token"],
        id: json["id"],
        refreshToken: json["refreshToken"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "refreshToken": refreshToken,
        "username": username
      };
}
