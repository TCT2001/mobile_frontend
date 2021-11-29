// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/modules/project/project_controller.dart';
import 'task_controller.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';

class TaskPage extends GetView<TaskController> {
  int? projectId;
  TaskPage.ofUser();
  TaskPage.ofProject({required this.projectId});

  // TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');
  // final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  // @override
  TaskController controller = Get.put(TaskController());
  //ProjectController projController = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Task")), body: Text("123"));
  }

  // // void deleteTask(Project project) {
  // //   controller.projects.where((element) => project.id != element.id);
  // // }
  // //
  // void renameOnPressed(Task task, String newName) async {
  //   CommonResp? commonResp = await controller.renameTask(task, newName);
  //   if (commonResp == null) {
  //     customSnackBar("Rename", "Some expected error happened");
  //     return;
  //   }
  //   if (commonResp.code == "SUCCESS") {
  //     customSnackBar("Rename", "Success");
  //   } else {
  //     customSnackBar("Rename", "Some expected error happened");
  //   }
  // }

  // // void createOnPressed(String newName) async {
  // //   CommonResp? commonResp = await controller.createProject(newName);
  // //   if (commonResp == null) {
  // //     customSnackBar("Create", "Some expected error happened");
  // //     return;
  // //   }
  // //   if (commonResp.code == "SUCCESS") {
  // //     customSnackBar("Create", "Success");
  // //   } else {
  // //     customSnackBar("Create", "Some expected error happened");
  // //   }
  // // }
  // //
  // void createOnPressed(String newName, String newContent) async {
  //   CommonResp? commonResp = await controller.createTask(newName, newContent);
  //   if (commonResp == null) {
  //     customSnackBar("Create", "Some expected error happened");
  //     return;
  //   }
  //   if (commonResp.code == "SUCCESS") {
  //     customSnackBar("Create", "Success");
  //   } else {
  //     customSnackBar("Create", "Some expected error happened");
  //   }
  // }

  // void createDialog() {
  //   Get.defaultDialog(
  //       titleStyle: const TextStyle(fontSize: 30),
  //       title: 'Create',
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: nameController,
  //             keyboardType: TextInputType.text,
  //             maxLines: 1,
  //             decoration: const InputDecoration(
  //                 labelText: 'Name',
  //                 hintMaxLines: 1,
  //                 border: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.green, width: 4.0))),
  //           ),
  //           const SizedBox(
  //             height: 15,
  //           ),
  //           TextField(
  //             controller: contentController,
  //             keyboardType: TextInputType.text,
  //             maxLines: 1,
  //             decoration: const InputDecoration(
  //                 labelText: 'Content',
  //                 hintMaxLines: 1,
  //                 border: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.green, width: 4.0))),
  //           ),
  //           const SizedBox(
  //             height: 15,
  //           ),
  //           const Text('Select Task Scope'),
  //           Obx(() => DropdownButton<String>(
  //                 // Set the Items of DropDownButton
  //                 items: const [
  //                   DropdownMenuItem(
  //                     value: "1",
  //                     child: Text(
  //                       "Public",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "2",
  //                     child: Text(
  //                       "Private",
  //                     ),
  //                   ),
  //                 ],
  //                 value: controller.selectedScope.value.toString(),
  //                 hint: Text('Select Task Scope'),
  //                 isExpanded: true,
  //                 onChanged: (selectedValue) {
  //                   controller.selectedScope.value = int.parse(selectedValue!);
  //                 },
  //               )),
  //           SizedBox(
  //             height: 15,
  //           ),
  //           Text('Select Task Priority'),
  //           Obx(() => DropdownButton<String>(
  //                 // Set the Items of DropDownButton
  //                 items: [
  //                   DropdownMenuItem(
  //                     value: "1",
  //                     child: Text(
  //                       "Critcal Priority",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "2",
  //                     child: Text(
  //                       "Major Priority",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "3",
  //                     child: Text(
  //                       "Normal Priority",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "4",
  //                     child: Text(
  //                       "Minor Priority",
  //                     ),
  //                   ),
  //                 ],
  //                 value: controller.selectedPriority.value.toString(),
  //                 hint: const Text('Select Task Priority'),
  //                 isExpanded: true,
  //                 onChanged: (selectedValue) {
  //                   controller.selectedPriority.value =
  //                       int.parse(selectedValue!);
  //                 },
  //               )),
  //           const SizedBox(
  //             height: 15,
  //           ),
  //           const Text('Select Task State'),
  //           Obx(() => DropdownButton<String>(
  //                 // Set the Items of DropDownButton
  //                 items: const [
  //                   DropdownMenuItem(
  //                     value: "1",
  //                     child: Text(
  //                       "Submitted",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "2",
  //                     child: Text(
  //                       "In Process",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "3",
  //                     child: Text(
  //                       "Incomplete",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "4",
  //                     child: Text(
  //                       "To be discussed",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "5",
  //                     child: Text(
  //                       "Done",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "6",
  //                     child: Text(
  //                       "Duplicate",
  //                     ),
  //                   ),
  //                   DropdownMenuItem(
  //                     value: "7",
  //                     child: Text(
  //                       "Obsolete",
  //                     ),
  //                   ),
  //                 ],
  //                 value: controller.selectedState.value.toString(),
  //                 hint: const Text('Select Task State'),
  //                 isExpanded: true,
  //                 onChanged: (selectedValue) {
  //                   controller.selectedState.value = int.parse(selectedValue!);
  //                 },
  //               )),
  //           const SizedBox(
  //             height: 15,
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Get.back();
  //               createOnPressed(nameController.text, contentController.text);
  //             },
  //             child: const Text(
  //               'Create',
  //               style: TextStyle(color: Colors.white, fontSize: 16.0),
  //             ),
  //           )
  //         ],
  //       ),
  //       radius: 10.0);
  // }

  // // void renameDialog(Task task) {
  // //   Get.defaultDialog(
  // //       titleStyle: TextStyle(fontSize: 0),
  // //       title: 'Rename',
  // //       content: Column(
  // //         mainAxisSize: MainAxisSize.min,
  // //         children: [
  // //           TextField(
  // //             controller: textController,
  // //             keyboardType: TextInputType.text,
  // //             maxLines: 1,
  // //             decoration: InputDecoration(
  // //                 labelText: 'New Name',
  // //                 hintMaxLines: 1,
  // //                 border: OutlineInputBorder(
  // //                     borderSide: BorderSide(color: Colors.green, width: 4.0))),
  // //           ),
  // //           SizedBox(
  // //             height: 30.0,
  // //           ),
  // //           ElevatedButton(
  // //             onPressed: () {
  // //               Get.back();
  // //               renameOnPressed(task, textController.text);
  // //             },
  // //             child: Text(
  // //               'Rename',
  // //               style: TextStyle(color: Colors.white, fontSize: 16.0),
  // //             ),
  // //           )
  // //         ],
  // //       ),
  // //       radius: 10.0);
  // // }

  // Widget customBody() {
  //   if (controller.tasks.isEmpty) {
  //     if (controller.isLastPage) {
  //       return Center(child: Text("No task"));
  //     } else {
  //       return Center(child: CircularProgressIndicator());
  //     }
  //   }
  //   var _items = controller.tasks;
  //   return LazyLoadScrollView(
  //       onEndOfPage: controller.nextPage,
  //       isLoading: controller.isLastPage,
  //       child: ListTileTheme(
  //         contentPadding: const EdgeInsets.all(15),
  //         iconColor: Colors.red,
  //         textColor: Colors.black54,
  //         tileColor: Colors.yellow[100],
  //         style: ListTileStyle.list,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         dense: true,
  //         child: ListView.builder(
  //           itemCount: _items.length,
  //           itemBuilder: (_, index) => GestureDetector(
  //             onTap: () {},
  //             child: Card(
  //               margin: const EdgeInsets.all(10),
  //               child: ListTile(
  //                 title: Text(_items[index].name!),
  //                 subtitle: const Text("Alo"),
  //                 trailing: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     IconButton(
  //                         onPressed: () {}, icon: const Icon(Icons.edit)),
  //                     IconButton(
  //                       icon: const Icon(Icons.delete),
  //                       onPressed: () {
  //                         Get.defaultDialog(
  //                           title: "Confirm",
  //                           middleText: "Are your sure to delete ?",
  //                           backgroundColor: Colors.white,
  //                           titleStyle: const TextStyle(color: Colors.black),
  //                           middleTextStyle:
  //                               const TextStyle(color: Colors.black),
  //                           actions: <Widget>[
  //                             TextButton(
  //                               child: const Text("Yes"),
  //                               onPressed: () async {},
  //                             ),
  //                             TextButton(
  //                               child: const Text("No"),
  //                               onPressed: () {
  //                                 Get.back();
  //                               },
  //                             ),
  //                           ],
  //                         );
  //                       },
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ));
  // }

  void updatePriorityDialog(Task task) {
      Get.defaultDialog(
          titleStyle: TextStyle(fontSize: 10),
          title: 'Select Task Priority',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => DropdownButton<String>(
                        // Set the Items of DropDownButton
                        items: [
                          // ignore: prefer_const_constructors
                          DropdownMenuItem(
                            value: "CRITICAL",
                            child: Text(
                              "Critcal Priority",
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          DropdownMenuItem(
                            value: "MAJOR",
                            child: Text(
                              "Major Priority",
                            ),
                          ),
                          DropdownMenuItem(
                            value: "NORMAL",
                            // ignore: prefer_const_constructors
                            child: Text(
                              "Normal Priority",
                            ),
                          ),
                          DropdownMenuItem(
                            value: "MINOR ",
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
                  updatePriorityOnPress(task,controller.selectedPriority.value);
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
      customSnackBar("Update Priority", "Some expected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Update Priority", "Success");
    } else {
      customSnackBar("Update Priority", "Some expected error happened");
    }
  }
}
