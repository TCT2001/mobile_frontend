import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/modules/example/example_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class ExamplePage extends GetView<ExampleController> {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextButton(onPressed: () => Get.toNamed(Routes.HOME), child: Text("Go to Home Page")),
              Text("Hello This is Example Page"),
            ],
          ),

        ));
  }
}
