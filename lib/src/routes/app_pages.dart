// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:mobile_app/src/modules/example/example_binding.dart';
import 'package:mobile_app/src/modules/example/example_page.dart';
import 'package:mobile_app/src/modules/home/home_binding.dart';
import 'package:mobile_app/src/modules/home/home_page.dart';
import 'package:mobile_app/src/modules/layout/main_layout_binding.dart';
import 'package:mobile_app/src/modules/layout/main_layout_page.dart';
import 'package:mobile_app/src/modules/login/login_signup_page.dart';
import 'package:mobile_app/src/modules/notification/noti_binding.dart';
import 'package:mobile_app/src/modules/notification/noti_page.dart';
import 'package:mobile_app/src/modules/project/project_binding.dart';
import 'package:mobile_app/src/modules/project/project_detail_page.dart';
import 'package:mobile_app/src/modules/project/project_page.dart';
import 'package:mobile_app/src/modules/splash/splash_page.dart';
import 'package:mobile_app/src/modules/task/task_detail_page.dart';
import 'package:mobile_app/src/modules/task/task_user_page.dart';

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
    GetPage(name: Routes.SPLASH, page: () => const SplashPage()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(
        name: Routes.PROJECT,
        page: () => ProjectPage(),
        binding: ProjectBinding()),
    GetPage(name: Routes.PROJECT_DETAIL, page: () => ProjectDetailPage()),
    // GetPage(
    //     name: Routes.TASK_PROJECT_PAGE,
    //     page: () => TaskProjectPage(),
    //     binding: TaskBinding()),
    GetPage(
      name: Routes.TASK_USER_PAGE,
      page: () => TaskUserPage(),
    ),
    GetPage(
      name: Routes.TASK_DETAIL_PAGE,
      page: () => TaskDetailPage(),
    ),
  ];
}