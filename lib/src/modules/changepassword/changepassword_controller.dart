import 'package:get/get.dart';
import 'package:mobile_app/src/data/models/payload/changepassword_resp.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';

class ChangePasswordController extends GetxController {
  var changepasswordProcess = false.obs;
  var error = "";

  Future<String> changepassword(
      {required String oldPassword, required String newPassword}) async {
    error = "";
    try {
      changepasswordProcess(true);
      CommonResp? changepasswordResp =
      await AuthService.changePassword(oldPassword, newPassword);
      if (changepasswordResp!.code == "SUCCESS") {
        return "";;
      } else {
        error = "Unexpected Error";
      }
    } finally {
      changepasswordProcess(false);
    }
    return error;
  }
}