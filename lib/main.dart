import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/modules/splash/splash_page.dart';

import 'src/data/services/app_config_service.dart';
import 'src/modules/splash/splash_binding.dart';
import 'src/routes/app_pages.dart';
import 'src/routes/app_routes.dart';

void main() async {
  await Get.putAsync(() => AppConfigService().init());
  runApp(GetMaterialApp(
    title: 'Makit',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    defaultTransition: Transition.fade,
    initialBinding: SplashBinding(),
    getPages: AppPages.pages,
    home: const SplashPage(),
  ));
}
