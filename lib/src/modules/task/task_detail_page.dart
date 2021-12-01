// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_controller.dart';
import 'package:select_form_field/select_form_field.dart';
import 'task_controller.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({Key? key}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskController controller = Get.put(TaskController());
  TaskController taskController = Get.put(TaskController());

  int id = Get.arguments['id'];
  late Future<Project> project;
  late Future<Task> task;

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  late TextEditingController invitedEmailController = TextEditingController();
  late TextEditingController newNameController = TextEditingController();
  late TextEditingController newContentController = TextEditingController();

  String invitedEmail = '';
  String role = '';
  String newTaskName = '';
  String newContentTask = '';

  @override
  void initState() {
    super.initState();
    // project = controller.find(id);
    task = controller.find(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                "Tự Viết Lại Appbar đi nó không giống project_detail_page đâu")),
        body: Column(
          children: <Widget>[
            Container(
              child: FutureBuilder<Task>(
                future: task,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.toString());
                  } else if (snapshot.hasError) {
                    return Text('Loi');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Text("Chưa có gì ở đây"),
              ),
            )
          ],
        ));
  }
}
