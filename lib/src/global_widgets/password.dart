import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/widgets_controller.dart';

class PasswordInput extends GetView<WidgetsController> {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: const TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
