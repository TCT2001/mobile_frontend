// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class TaskPage extends GetView<TaskController> {
  TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is Tasks Page"));
  }
}
