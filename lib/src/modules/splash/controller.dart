import 'package:get/get.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class SplashController extends GetxController {
  splashF() async => await Future.delayed(
      const Duration(seconds: 3), () => Get.toNamed(Routes.HOME));
}
