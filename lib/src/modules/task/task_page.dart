// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class TaskPage extends GetView<TaskController> {
  int? projectId;
  int? userId;
  TaskPage.ofUser();
  TaskPage.ofProject({required this.projectId});

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
              padding: const EdgeInsets.all(125),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      projectId == null
                          ? Text("This is task page of user",
                              style: TextStyle(
                                  color: Color(0xff88e8f2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))
                          : Text("This is task page of projects",
                              style: TextStyle(
                                  color: Color(0xff88e8f2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                    ]),
              ))),
    );
  }
}
