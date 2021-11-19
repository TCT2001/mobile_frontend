// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:mobile_app/src/modules/example/example_binding.dart';
import 'package:mobile_app/src/modules/example/example_page.dart';
import 'package:mobile_app/src/modules/home/home_binding.dart';
import 'package:mobile_app/src/modules/home/home_page.dart';
import 'package:mobile_app/src/modules/init/init_binding.dart';
import 'package:mobile_app/src/modules/init/init_page.dart';
import 'package:mobile_app/src/modules/layout/main_layout_binding.dart';
import 'package:mobile_app/src/modules/layout/main_layout_page.dart';
import 'package:mobile_app/src/modules/login/login_binding.dart';
import 'package:mobile_app/src/modules/login/login_page.dart';
import 'package:mobile_app/src/modules/notification/noti_binding.dart';
import 'package:mobile_app/src/modules/notification/noti_page.dart';
import 'package:mobile_app/src/modules/project/project_binding.dart';
import 'package:mobile_app/src/modules/project/project_page.dart';
import 'package:mobile_app/src/modules/signup/signup_binding.dart';
import 'package:mobile_app/src/modules/signup/signup_page.dart';
import 'package:mobile_app/src/modules/splash/splash_page.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.SPLASH, page: () => const SplashPage()),
    GetPage(
        name: Routes.EXAMPLE,
        page: () => const ExamplePage(),
        binding: ExampleBinding()),
    GetPage(
        name: Routes.NOTIFICATION,
        page: () => NotiPage(),
        binding: NotiBinding()),
    GetPage(
        name: Routes.MAIN,
        page: () => MainLayoutPage(),
        binding: MainLayoutBinding()),
    GetPage(
        name: Routes.INIT,
        page: () => const InitPage(),
        binding: InitBinding()),
    GetPage(name: Routes.SPLASH, page: () => const SplashPage()),
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.SIGNUP,
        page: () => const SignupPage(),
        binding: SignupBinding()),
    GetPage(
        name: Routes.PROJECT,
        page: () => ProjectPage(),
        binding: ProjectBinding()),
  ];
}
