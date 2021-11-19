// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/login_resp.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  // state
  var loginProcess = false.obs;
  var error = "";

  Future<String> login(
      {required String email, required String password}) async {
    error = "";
    try {
      loginProcess(true);
      LoginResp loginResp =
          await AuthService.login(email: email, password: password);
      if (loginResp.code == "SUCCESS") {
        setStringLocalStorge(LocalStorageKey.EMAIL.toString(),
            loginResp.loginRespData!.email);
        setIntLocalStorge(LocalStorageKey.USER_ID.toString(),
            loginResp.loginRespData!.id);
        setStringLocalStorge(LocalStorageKey.TOKEN.toString(),
            loginResp.loginRespData!.token);
        setStringLocalStorge(LocalStorageKey.REFRESH_TOKEN.toString(),
            loginResp.loginRespData!.refreshToken);
      } else {
        error = "Unexpected Error";
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }

  Future<bool> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

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
