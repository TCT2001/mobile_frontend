import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import 'package:mobile_app/src/global_widgets/widgets_controller.dart';

class InputEmail extends GetView<WidgetsController> {
  const InputEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}