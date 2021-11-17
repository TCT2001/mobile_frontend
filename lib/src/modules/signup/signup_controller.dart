import 'package:get/get.dart';
import 'package:mobile_app/src/data/models/payload/signup_resp.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';

class SignupController extends GetxController {
  var signupProcess = false.obs;
  var error = "";

  Future<String> signup(
      {required String email, required String password}) async {
    error = "";
    try {
      signupProcess(true);
      SignupResp signupResp =
          await AuthService.signup(email: email, password: password);
      if (signupResp.code == "SUCCESS") {
        return "";
      } else {
        error = "Unexpected Error";
      }
    } finally {
      signupProcess(false);
    }
    return error;
  }
}
