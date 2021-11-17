import 'dart:convert';

SignupResp signupRespFromJson(String str) {
  return SignupResp.fromJson(json.decode(str));
}

String signupRespToJson(SignupResp data) => json.encode(data.toJson());

class SignupResp {
  late String code;
  SignupResp({required this.code});
  factory SignupResp.fromJson(Map<String, dynamic> json) =>
      SignupResp(code: json["code"]);

  Map<String, dynamic> toJson() => {"code": code};
}
