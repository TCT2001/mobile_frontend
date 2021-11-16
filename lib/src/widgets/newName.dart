import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/widgets/widgets_controller.dart';

class NewName extends GetView<WidgetsController> {
  const NewName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
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
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
