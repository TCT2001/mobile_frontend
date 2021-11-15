// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(children: [
            TextButton(onPressed: goToExamplePage, child: Text("Go To Example Page")),
            Text("Hello This is Home Page"),
          ],),
        ));
  }

  void goToExamplePage() {
    Get.toNamed(Routes.EXAMPLE);
  }
}
