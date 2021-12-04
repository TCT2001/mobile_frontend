import 'dart:convert';

ChangePasswordResp changePasswordRespFromJson(String str) {
  return ChangePasswordResp.fromJson(json.decode(str));
}

String changePasswordRespToJson(ChangePasswordResp data) => json.encode(data.toJson());

class ChangePasswordResp {
  late String code;
  ChangePasswordResp({required this.code});
  factory ChangePasswordResp.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResp(code: json["code"]);

  Map<String, dynamic> toJson() => {"code": code};
}
