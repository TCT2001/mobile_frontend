import 'package:get/get.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class SplashController extends GetxController {
  splashF() async => await Future.delayed(
      //TODO
      const Duration(seconds: 1),
      () => Get.toNamed(Routes.INIT));
}
