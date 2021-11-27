import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/payload/login_resp.dart';
import 'package:mobile_app/src/data/models/payload/signup_resp.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      LoginResp loginResp =
      await AuthService.login(email: data.name, password: data.password);
      print(loginResp.code);
      print(loginResp.loginRespData);
      if (loginResp.code == "SUCCESS") {
        setStringLocalStorge(
            LocalStorageKey.EMAIL.toString(), loginResp.loginRespData!.email);
        setIntLocalStorge(
            LocalStorageKey.USER_ID.toString(), loginResp.loginRespData!.id);
        setStringLocalStorge(
            LocalStorageKey.TOKEN.toString(), loginResp.loginRespData!.token);
        setStringLocalStorge(LocalStorageKey.REFRESH_TOKEN.toString(),
            loginResp.loginRespData!.refreshToken);
        return null;
      } else {
        return "Email or password is incorrect !";
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    print('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      SignupResp signupResp =
      await AuthService.signup(email: data.name!, password: data.password!);
      if (signupResp.code == "SUCCESS") {
        return null;
      } else {
        return "Email already exists";
      }
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/Logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Get.offAllNamed(Routes.MAIN);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}