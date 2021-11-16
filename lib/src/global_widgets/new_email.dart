import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/widgets_controller.dart';

class NewEmail extends GetView<WidgetsController> {
  const NewEmail({Key? key}) : super(key: key);

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
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'E-mail',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
