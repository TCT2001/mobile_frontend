// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: Padding(
              padding: const EdgeInsets.all(150),

              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("This is task page",
                          style: TextStyle(
                              color: Color(0xff88e8f2),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(height: 8),

                      SizedBox(height: 8),


                    ]),
              )
          )),
    )
    ;
  }
}
