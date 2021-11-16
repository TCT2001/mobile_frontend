import 'package:get/get.dart';
import 'package:mobile_app/src/modules/example/example_binding.dart';
import 'package:mobile_app/src/modules/example/example_page.dart';
import 'package:mobile_app/src/modules/home/home_binding.dart';
import 'package:mobile_app/src/modules/home/home_page.dart';
import 'package:mobile_app/src/modules/layout/main_layout_binding.dart';
import 'package:mobile_app/src/modules/layout/main_layout_page.dart';
import 'package:mobile_app/src/modules/notification/noti_binding.dart';
import 'package:mobile_app/src/modules/notification/noti_page.dart';
import 'package:mobile_app/src/modules/splash/splash_page.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.SPLASH, page: () => const SplashPage()),
    GetPage(name: Routes.EXAMPLE, page: () => const ExamplePage(), binding: ExampleBinding()),
    GetPage(name: Routes.NOTIFICATION, page: () => NotiPage(), binding: NotiBinding()),
    GetPage(name: Routes.MAIN, page: () => MainLayoutPage(), binding: MainLayoutBinding())

  ];
}