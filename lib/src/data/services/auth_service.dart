// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/invitation.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/payload/error_resp.dart';
import 'package:mobile_app/src/data/models/payload/login_resp.dart';
import 'package:mobile_app/src/data/models/payload/noti_resp.dart';
import 'package:mobile_app/src/data/models/payload/signup_resp.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class AuthService {
  static Uri REFRESH_TOKEN_URI = Uri.parse('$baseURL/auth/refreshToken');
  static Uri SIGN_UP_URI = Uri.parse('$baseURL/auth/signup');
  static Uri LOGIN_URI = Uri.parse('$baseURL/auth/signin');
  static Uri LOGOUT_URI = Uri.parse('$baseURL/auth/logout');
  static Uri RE_PASS_WORD_URI = Uri.parse('$baseURL/auth/changePassword');

  //TODO
  static Future<List> refreshToken({required String token}) async {
    var response =
        await client.post(REFRESH_TOKEN_URI, headers: <String, String>{
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      //status is success but not excepted result
      if (json.contains("access_token") == false) {
        return ["", "Unknown Error"];
      }
      var loginRes = loginRespFromJson(json);
      return [loginRes.loginRespData!.token, ""];
    } else {
      var json = response.body;
      var errorResp = errorRespFromJson(json);
      return ["", errorResp.error];
    }
  }

  static Future<SignupResp> signup(
      {required String email, required String password}) async {
    var response = await client.post(SIGN_UP_URI,
        headers: nonAuthHeader,
        body: jsonEncode(
            <String, String>{"username": email, "password": password}));
    return signupRespFromJson(response.body);
  }

  static Future<LoginResp> login(
      {required String email, required String password}) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;
    //TODO
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   print('Running on ${androidInfo.model}');
    //   deviceId = await deviceInfo.androidInfo.then((value) => value.androidId);
    // } else if (Platform.isIOS) {
    //   deviceId =
    //       await deviceInfo.iosInfo.then((value) => value.identifierForVendor);
    // }
    var fcmToken = "333";
    // await FirebaseMessaging.instance.getToken().then((token) {
    //   fcmToken = token!;
    // });
    var response = await client.post(LOGIN_URI,
        headers: nonAuthHeader,
        body: jsonEncode(<String, String>{
          "username": email,
          "password": password,
          "deviceId": "123",
          "isAndroid": "1",
          "fcmToken": fcmToken
          //TODO
        }));
    return loginRespFromJson(response.body);
  }

  static Future<List<NotificationCustom>> listNoti() async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(
      Uri.parse("$baseURL/notification/list"),
      headers: authHeader(token!),
    );
    List? temp = json.decode(response.body) as List;
    List<NotificationCustom> rs =
        temp.map((e) => NotificationCustom.fromJson(e)).toList();
    return rs;
  }

  static Future<List<Invitation>> listInvi() async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(
      Uri.parse("$baseURL/auth/getInvitation"),
      headers: authHeader(token!),
    );
    List? temp = json.decode(response.body) as List;
    List<Invitation> rs = temp.map((e) => Invitation.fromJson(e)).toList();
    return rs;
  }

  static Future<CommonResp> acceptInvitation(String arg, int id) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(
        Uri.parse("$baseURL/auth/responseInvitation/$arg"),
        headers: authHeader(token!),
        body: jsonEncode(<String, String>{"id": id.toString()}));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      //print(temp);
      return temp;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<CommonResp?> changePassword(
      String oldPassword, String newPassword) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.put(Uri.parse('$baseURL/auth/changePassword'),
        headers: authHeader(token!),
        body: jsonEncode(<String, String>{
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        }));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }
}
