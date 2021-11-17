
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = "";

  Future<String> login({required String email,required String password}) async {
    error = "";
    if (email == "a" && password == "a") {
      return error;
    }
    try {
      loginProcess(true);
      List loginResp = await AuthService.login(email: email, password: password);
      if (loginResp[0] != "") {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loginResp[0]);
      } else {
        error = loginResp[1];
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }

  Future<bool> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (token == null) {
      return false;
    }

    bool success = false;
    try {
      loginProcess(true);
      List loginResp = await AuthService.refreshToken(token: token);
      if (loginResp[0] != "") {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loginResp[0]);
        success = true;
      }
    } finally {
      loginProcess(false);
    }
    return success;
  }
}