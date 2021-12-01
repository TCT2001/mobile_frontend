import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class SplashController extends GetxController {
  splashF() async {
    // await Future.delayed(
    //     const Duration(seconds: 1),
    //     () => Get.toNamed(Routes.INIT));
    if (await getStringLocalStorge(LocalStorageKey.TOKEN.toString()) != null) {
      Get.offAllNamed(Routes.MAIN);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
