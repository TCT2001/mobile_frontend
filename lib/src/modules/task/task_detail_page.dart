// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_controller.dart';
import 'package:mobile_app/src/modules/task/task_project_page.dart';
//ai sua ho cai list xong moi check lam` dc cai nay` nhe'
class TaskDetailPage extends GetView<TaskController>{
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');

  Task taskClicked = Get.arguments['task'];

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  TaskController controller = Get.put(TaskController());

  AppBar? taskAppBar(){
    return AppBar(
      title: Text('Task detail'),
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          //Ban sua giup toi dua ve` cai list task trc day' nhe'
        },
        child: Icon(
          Icons.arrow_back, // add custom icons also
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
        PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 0) {
              nameController.text = "";
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
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp = await controller.renameTask(taskClicked, nameController.text);
                          if (commonResp == null) {
                            customSnackBar("Rename", "Some unexpected error happened");
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            customSnackBar("Rename", "Success");
                          } else {
                            customSnackBar("Rename", "Some unexpected error happened");
                          }
                        },
                        child: Text(
                          'Rename',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            }
            else if (value == 1) {
              Get.defaultDialog(
                title: "Confirm",
                middleText: "Are your sure to delete ?",
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.black),
                middleTextStyle:
                const TextStyle(color: Colors.black),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () async {
                      Get.back();
                      bool rs = await controller.deleteTask(taskClicked);
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
            }
            else if (value == 2) {
              Get.defaultDialog(
                  titleStyle: TextStyle(fontSize: 10),
                  title: 'Select Task State',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => DropdownButton<String>(
                        // Set the Items of DropDownButton
                        items: [
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
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp = await controller.updateState(taskClicked, controller.selectedState.value.toString());
                          if (commonResp == null) {
                            customSnackBar("Update State", "Some expected error happened");
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            customSnackBar("Update State", "Success");
                          } else {
                            customSnackBar("Update State", "Some expected error happened");
                          }
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
            else if (value == 3) {
              Get.defaultDialog(
                  titleStyle: TextStyle(fontSize: 10),
                  title: 'Select Task Priority',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => DropdownButton<String>(
                        // Set the Items of DropDownButton
                        items: [
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
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp = await controller.updatePriority(taskClicked, controller.selectedPriority.value.toString());
                          if (commonResp == null) {
                            customSnackBar("Rename", "Some expected error happened");
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            customSnackBar("Update Priority", "Success");
                          } else {
                            customSnackBar("Update Priority", "Some expected error happened");
                          }
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
            else if(value == 4){
              contentController.text = "";
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
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp = await controller.updateContent(taskClicked, contentController.text);
                          if (commonResp == null) {
                            customSnackBar("Rename", "Some unexpected error happened");
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            customSnackBar("Update Content", "Success");
                          } else {
                            customSnackBar("Update Content", "Some unexpected error happened");
                          }
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
          },
          key: _key,
          itemBuilder: (context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Rename Task'), value: 0),
              PopupMenuItem(child: Text('Delete Task'), value: 1),
              PopupMenuItem(child: Text('Update State'), value: 2),
              PopupMenuItem(child: Text('Create Priority'), value: 3),
              PopupMenuItem(child: Text('Create Content'), value: 4),
            ];
          },
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(appBar: taskAppBar(),
        body: Text('Task Detail chua biet viet gi')
    );
  }
}