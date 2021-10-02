import 'package:get/get.dart';
import 'package:mobile_app/src/modules/home/home_binding.dart';
import 'package:mobile_app/src/modules/home/home_page.dart';
import 'package:mobile_app/src/modules/splash/splash_page.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => const HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.SPLASH, page: () => const SplashPage())
  ];
}