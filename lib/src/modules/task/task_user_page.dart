// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import 'task_user_controller.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';

final List<Map<String, dynamic>> _items = [
  {
    'value': 'ADMINISTRATOR',
    'label': 'Admin',
    'icon': Icon(Icons.stop),
  },
  {
    'value': 'MEMBER',
    'label': 'Member',
    'icon': Icon(Icons.fiber_manual_record),
    'textStyle': TextStyle(color: Colors.red),
  },
  {
    'value': 'OBSERVER',
    'label': 'observer',
    'icon': Icon(Icons.grade),
  },
];

class TaskUserPage extends GetView<TaskUserController> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');
  TextEditingController invitedEmailController =
  TextEditingController(text: '');

  late Task task;
  String invitedEmail = '';
  String role = '';
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  TaskUserPage({Key? key}) : super(key: key);

//TODO
  AppBar? taskAppBar() {
    return AppBar(
        backgroundColor: Color(0xff2d5f79),
        title: Text('Tasks of User'),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.menu, // add custom icons also
          ),
        ),
        actionsIconTheme:
        IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
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
        ]);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: '');
    return Scaffold(
        appBar: taskAppBar(),
        body: Column(
          children: <Widget>[
            Container(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                  ),
                  onChanged: (String? value) {
                    controller.searchByName(value!);
                    controller.update();
                  },
                )),
            Expanded(
              child: Container(child: customBody()),
            )
          ],
        ));
  }

  Widget customBody() {
    TaskUserController controller = Get.put(TaskUserController());
    return Obx(() {
      var _items = controller.tasks;
      if (controller.tasks.isEmpty) {
        if (controller.isLastPage) {
          return Center(child: Text("No task"));
        }
        return Center(child: CircularProgressIndicator());
      }

      return LazyLoadScrollView(
          onEndOfPage: controller.nextPage,
          isLoading: controller.isLastPage,
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(15),
            iconColor: Colors.black45,
            textColor: Colors.black,
            tileColor: BathWater,
            style: ListTileStyle.list,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            dense: true,
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                Task task = _items[index];
                String deadline = task.deadline??"no set";
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.TASK_DETAIL_PAGE, arguments: {
                      "id": _items[index].id,
                      "task": _items[index]
                    });
                  },
                  child: Card(
                    color: BathWater,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text("📄 Task: ${task.name}"),
                      subtitle: Text("\n📋  State: ${task.taskState} \n      BriefContent: ${task.briefContent} \n      Deadline: ${deadline}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                renameDialog(_items[index]);
                                nameController.text = "";
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Confirm",
                                middleText: "Are your sure to delete ?",
                                backgroundColor: Colors.white,
                                titleStyle:
                                const TextStyle(color: Colors.black),
                                middleTextStyle:
                                const TextStyle(color: Colors.black),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Yes"),
                                    onPressed: () async {
                                      Get.back();
                                      bool rs = await controller
                                          .deleteTask(_items[index]);
                                      if (rs) {
                                        customSnackBar("Delete", "Success",
                                            iconData: Icons.check_outlined,
                                            iconColor: Colors.green);
                                      }
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("No"),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
    });
  }

  void renameDialog(Task task) {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        title: 'Rename',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'New Name',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4.0))),
            ),
            SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                renameOnPressed(task, nameController.text);
              },
              child: Text(
                'Rename',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2d5f79)) ),
            )
          ],
        ),
        radius: 10.0);
  }

  void renameOnPressed(Task task, String newName) async {
    CommonResp? commonResp = await controller.renameTask(task, newName);
    if (commonResp == null) {
      customSnackBar("Rename", "Some unexpected error happened",
          iconData: Icons.warning_rounded, iconColor: Colors.red);
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Rename", "Success",
          iconData: Icons.check_outlined, iconColor: Colors.green);
    } else {
      customSnackBar("Rename", "Some unexpected error happened",
          iconData: Icons.warning_rounded, iconColor: Colors.red);
    }
  }

  void updateStateDialog(Task task) {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 10),
        title: 'Select Task State',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => DropdownButton<String>(
              // Set the Items of DropDownButton
              items: const [
                DropdownMenuItem(
                  value: "SUBMITTED",
                  child: Text(
                    "SUBMITTED",
                  ),
                ),
                DropdownMenuItem(
                  value: "IN_PROCESS",
                  child: Text(
                    "IN PROCESS",
                  ),
                ),
                DropdownMenuItem(
                  value: "INCOMPLETE",
                  child: Text(
                    "INCOMPLETE",
                  ),
                ),
                DropdownMenuItem(
                  value: "TO_BE_DISCUSSED",
                  child: Text(
                    "TO BE DISCUSSED",
                  ),
                ),
                DropdownMenuItem(
                  value: "DONE",
                  child: Text(
                    "DONE",
                  ),
                ),
                DropdownMenuItem(
                  value: "DUPLICATE",
                  child: Text(
                    "DUPLICATE",
                  ),
                ),
                DropdownMenuItem(
                  value: "OBSOLETE",
                  child: Text(
                    "OBSOLETE",
                  ),
                ),
              ],
              value: controller.selectedState.value.toString(),
              hint: const Text('Select Task Priority'),
              isExpanded: true,
              onChanged: (selectedValue) {
                controller.selectedState.value = selectedValue!;
              },
            )),
            ElevatedButton(
              onPressed: () {
                Get.back();
                updateStateOnPress(
                    task, controller.selectedState.value.toString());
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
  }

  void updateStateOnPress(Task task, String newState) async {
    CommonResp? commonResp = await controller.updateState(task, newState);
    if (commonResp == null) {
      customSnackBar("Update State", "Some expected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Update State", "Success");
    } else {
      customSnackBar("Update State", "Some expected error happened");
    }
  }

  void updatePriorityDialog(Task task) {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 10),
        title: 'Select Task Priority',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => DropdownButton<String>(
              // Set the Items of DropDownButton
              items: const [
                DropdownMenuItem(
                  value: "CRITICAL",
                  child: Text(
                    "Critcal Priority",
                  ),
                ),
                DropdownMenuItem(
                  value: "MAJOR",
                  child: Text(
                    "Major Priority",
                  ),
                ),
                DropdownMenuItem(
                  value: "NORMAL",
                  child: Text(
                    "Normal Priority",
                  ),
                ),
                DropdownMenuItem(
                  value: "MINOR",
                  child: Text(
                    "Minor Priority",
                  ),
                ),
              ],
              value: controller.selectedPriority.value.toString(),
              hint: const Text('Select Task Priority'),
              isExpanded: true,
              onChanged: (selectedValue) {
                controller.selectedPriority.value = selectedValue!;
              },
            )),
            ElevatedButton(
              onPressed: () {
                Get.back();
                updatePriorityOnPress(
                    task, controller.selectedPriority.value.toString());
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
  }

  void updatePriorityOnPress(Task task, String newPriority) async {
    CommonResp? commonResp = await controller.updatePriority(task, newPriority);
    if (commonResp == null) {
      customSnackBar("Rename", "Some expected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Update Priority", "Success");
    } else {
      customSnackBar("Update Priority", "Some expected error happened");
    }
  }

  void updateContentDialog(Task task) {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        title: 'Update Content',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: contentController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'New Content',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4.0))),
            ),
            SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                updateContentOnPressed(task, contentController.text);
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
  }

  void updateContentOnPressed(Task task, String newContent) async {
    CommonResp? commonResp = await controller.updateContent(task, newContent);
    if (commonResp == null) {
      customSnackBar("Rename", "Some unexpected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Update Content", "Success");
    } else {
      customSnackBar("Update Content", "Some unexpected error happened");
    }
  }
}