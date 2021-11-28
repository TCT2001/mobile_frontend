import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_controller.dart';

class TaskUserPage extends GetView<TaskController> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  TaskController controller = Get.put(TaskController());

  AppBar? taskAppBar() {
    return AppBar(
      title: const Text('Tasks of User'),
      automaticallyImplyLeading: false,
      actionsIconTheme:
      IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      leading: GestureDetector(
        onTap: () {
          /* Write listener code here */
        },
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )),
        PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 0) {
              customSnackBar("Create Task", "Pressed");
              nameController.text = "";
              contentController.text = "";
            }
          },
          key: _key,
          itemBuilder: (context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Create task'), value: 0),
            ];
          },
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(appBar: taskAppBar(),
        body: Text('Task User Page')
    );
  }
}