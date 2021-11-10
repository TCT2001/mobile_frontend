import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/data/services/app_config_service.dart';
import 'src/modules/splash/splash_binding.dart';
import 'src/modules/splash/splash_page.dart';
import 'src/routes/app_pages.dart';
import 'src/routes/app_routes.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/TabItem.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => AppConfigService().init());
  
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    defaultTransition: Transition.fade,
    initialBinding: SplashBinding(),
    getPages: AppPages.pages,
    home: const SplashPage(),
  ));
}