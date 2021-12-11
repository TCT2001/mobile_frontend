import 'dart:convert';

ForgotpassResp forgotpassRespFromJson(String str) {
  return ForgotpassResp.fromJson(json.decode(str));
}

String forgotpassRespToJson(ForgotpassResp data) => json.encode(data.toJson());

class ForgotpassResp {
  late String code;
  ForgotpassResp({required this.code});
  factory ForgotpassResp.fromJson(Map<String, dynamic> json) =>
      ForgotpassResp(code: json["code"]);

  Map<String, dynamic> toJson() => {"code": code};
}
