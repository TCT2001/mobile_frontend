import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_app/src/core/utils/validator_utils.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/forgotpassword_resp.dart';
import 'package:mobile_app/src/data/models/payload/login_resp.dart';
import 'package:mobile_app/src/data/models/payload/signup_resp.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 1000);

  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      LoginResp loginResp =
          await AuthService.login(email: data.name, password: data.password);

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
    return Future.delayed(loginTime).then((_) async {
      SignupResp signupResp =
          await AuthService.signup(email: data.name!, password: data.password!);
      if (signupResp.code == "SUCCESS") {
        LoginData loginData = LoginData(name: data.name!, password: data.password!);
        _authUser(loginData);
        Get.toNamed(Routes.LOGIN);
      } else {
        return "Email already exists";
      }
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) async {
      ForgotpassResp forgotpassResp = await AuthService.forgotpass(email: name);
      if (forgotpassResp.code == "SUCCESS") {
        return null;
      } else {
        return "Email is incorrect";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/Logo.png'),
      userValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your email or phone number";
        }
        if (!EmailValidator.validate(value) && !phoneRegExp.hasMatch(value)) {
          return "Please enter your email or phone number";
        }
        return null;
      },
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Get.offAllNamed(Routes.MAIN);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
