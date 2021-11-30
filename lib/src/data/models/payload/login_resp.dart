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

  factory LoginResp.fromJson(Map<String, dynamic> json){ 
    String code = json["code"];
    if (code == "SUCCESS") {
    return LoginResp(
        code: json["code"],
        loginRespData: LoginRespData.fromJson(json["data"]),
      );
    } else {
      return LoginResp(code: json["code"]);
    }
  }

  Map<String, dynamic> toJson() =>
      {"code": code, "data": json.encode(loginRespData!.toJson())};
}

class LoginRespData {
  late String token;
  late int id;
  late String refreshToken;
  late String email;

  LoginRespData.empty();

  LoginRespData(
      {required this.token,
      required this.id,
      required this.refreshToken,
      required this.email});

  factory LoginRespData.fromJson(Map<String, dynamic> json) => LoginRespData(
        token: json["token"],
        id: json["id"],
        refreshToken: json["refreshToken"],
        email: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "refreshToken": refreshToken,
        "username": email
      };
}
