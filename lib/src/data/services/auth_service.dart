import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/models/payload/error_resp.dart';
import 'package:mobile_app/src/data/models/payload/login_resp.dart';

class AuthService {
  static Future<List> refreshToken({required String token}) async {
    var url = Uri.parse('$baseURL/auth/refreshToken');

    var response = await client.post(url, headers: <String, String>{
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      //status is success but not excepted result
      if (json.contains("access_token") == false) {
        return ["", "Unknown Error"];
      }
      var loginRes = loginRespFromJson(json);
      if (loginRes != null) {
        return [loginRes.loginRespData!.token, ""];
      } else {
        return ["", "Unknown Error"];
      }
    } else {
      var json = response.body;
      var errorResp = errorRespFromJson(json);
      if (errorResp == null) {
        return ["", "Unknown Error"];
      } else {
        return ["", errorResp.error];
      }
    }
  }

  static Future<List> login(
      {required String email, required String password}) async {
    var url = Uri.parse('$baseURL/auth/signin');
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{"username": email, "password": password}));
    if (response.statusCode == 200) {
      var json = response.body;
      var loginRes = loginRespFromJson(json);
      if (loginRes != null) {
        return [loginRes.loginRespData!.token, ""];
      } else {
        return ["", "Unknown Error"];
      }
    } else {
      var json = response.body;
      var errorResp = errorRespFromJson(json);
      if (errorResp == null) {
        return ["", "Unknown Error"];
      } else {
        return ["", errorResp.error];
      }
    }
  }
}