// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/models/payload/error_resp.dart';
import 'package:mobile_app/src/data/models/payload/login_resp.dart';
import 'package:mobile_app/src/data/models/payload/signup_resp.dart';

class AuthService {
  static Uri REFRESH_TOKEN_URI = Uri.parse('$baseURL/auth/refreshToken');
  static Uri SIGN_UP_URI = Uri.parse('$baseURL/auth/signup');
  static Uri LOGIN_URI = Uri.parse('$baseURL/auth/signin');
  static Uri LOGOUT_URI = Uri.parse('$baseURL/auth/logout');

  //TODO
  static Future<List> refreshToken({required String token}) async {
    var response = await client.post(REFRESH_TOKEN_URI, headers: <String, String>{
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

  static Future<SignupResp> signup(
      {required String email, required String password}) async {
    var response = await client.post(SIGN_UP_URI,
        headers: nonAuthHeader,
        body:
            jsonEncode(<String, String>{"username": email, "password": password}));
    return signupRespFromJson(response.body);
  }

  static Future<LoginResp> login(
      {required String email, required String password}) async {
    var response = await client.post(LOGIN_URI,
        headers: nonAuthHeader,
        body:
            jsonEncode(<String, String>{"username": email, "password": password}));
    return loginRespFromJson(response.body);
  }
}