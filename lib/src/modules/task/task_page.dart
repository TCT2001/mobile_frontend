// ignore_for_file: unnecessary_this, prefer_const_constructors

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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //         decoration: const BoxDecoration(
  //           gradient: LinearGradient(
  //               begin: Alignment.topRight,
  //               end: Alignment.bottomLeft,
  //               colors: [Colors.blueGrey, Colors.lightBlueAccent]),
  //         ),
  //         child: Padding(
  //             padding: const EdgeInsets.all(125),
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height,
  //               child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     projectId == null
  //                         ? Text("This is task page of user",
  //                             style: TextStyle(
  //                                 color: Color(0xff88e8f2),
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 18))
  //                         : Text("This is task page of project",
  //                             style: TextStyle(
  //                                 color: Color(0xff88e8f2),
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 18)),
  //                     SizedBox(height: 8),
  //                     SizedBox(height: 8),
  //                   ]),
  //             ))),
  //   );
  // }

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  TaskController controller = Get.put(TaskController());
  ProjectController projController = Get.put(ProjectController());

  AppBar? taskAppBar() {
    if (projectId == null) {
      return AppBar(
        title: const Text('Tasks of User'),
        automaticallyImplyLeading: false,
        actionsIconTheme:
        IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
        leading: GestureDetector(
          onTap: () {/* Write listener code here */},
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
                createDialog();
                nameController.text = "";
                contentController.text = "";
              }
            },
            key: _key,
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(child: Text('Create'), value: 0),
              ];
            },
          ),
        ],
      );
    } else {
      return AppBar(
        title: Text('Tasks of project'),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            projController.changeChoice(0, null);
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
                createDialog();
                nameController.text = "";
                contentController.text = "";
              }
            },
            key: _key,
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(child: Text('Create'), value: 0),
              ];
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(appBar: taskAppBar(), body: customBody()));
  }
  // Widget customBody() {
  //   if (controller.choice == 1) {
  //     return bodyChoiceOne();
  //   } else {
  //     return bodyChoiceZero();
  //   }
  // }

  void deleteTask(Task task) {
    controller.tasks.where((element) => task.id != element.id);
  }

  void renameOnPressed(Task task, String newName) async {
    CommonResp? commonResp = await controller.renameTask(task, newName);
    if (commonResp == null) {
      customSnackBar("Rename", "Some unexpected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Rename", "Success");
    } else {
      customSnackBar("Rename", "Some unexpected error happened");
    }
  }


  void createOnPressed(String newName, String newContent, int id) async {
    CommonResp? commonResp = await controller.createTask(newName, newContent, id);
    if (commonResp == null) {
      customSnackBar("Create", "Some expected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Create", "Success");
    } else {
      customSnackBar("Create", "Some expected error happened");
    }

  }

  void updateContentOnPressed(Task task, String newName) async {
    CommonResp? commonResp = await controller.updateContent(task, newName);
    if (commonResp == null) {
      customSnackBar("Update", "Some unexpected error happened");
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Update", "Success");
    } else {
      customSnackBar("Update", "Some unexpected error happened");
    }
  }

  void createDialog() {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 30),
        title: 'Create',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Name',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4.0))),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: contentController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Content',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4.0))),
            ),
            SizedBox(
              height: 15,
            ),
            // Text('Select Task Scope'),
            // Obx(() => DropdownButton<String>(
            //   // Set the Items of DropDownButton
            //   items: [
            //     DropdownMenuItem(
            //       value: "1",
            //       child: Text(
            //         "Public",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "2",
            //       child: Text(
            //         "Private",
            //       ),
            //     ),
            //   ],
            //   value: controller.selectedScope.value.toString(),
            //   hint: Text('Select Task Scope'),
            //   isExpanded: true,
            //   onChanged: (selectedValue) {
            //     controller.selectedScope.value =
            //         int.parse(selectedValue!);
            //   },
            // )),
            // SizedBox(
            //   height: 15,
            // ),
            // Text('Select Task Priority'),
            // Obx(() => DropdownButton<String>(
            //   // Set the Items of DropDownButton
            //   items: [
            //     DropdownMenuItem(
            //       value: "1",
            //       child: Text(
            //         "Critcal Priority",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "2",
            //       child: Text(
            //         "Major Priority",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "3",
            //       child: Text(
            //         "Normal Priority",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "4",
            //       child: Text(
            //         "Minor Priority",
            //       ),
            //     ),
            //   ],
            //   value: controller.selectedPriority.value.toString(),
            //   hint: Text('Select Task Priority'),
            //   isExpanded: true,
            //   onChanged: (selectedValue) {
            //     controller.selectedPriority.value =
            //         int.parse(selectedValue!);
            //   },
            // )),
            // SizedBox(
            //   height: 15,
            // ),
            // Text('Select Task State'),
            // Obx(() => DropdownButton<String>(
            //   // Set the Items of DropDownButton
            //   items: [
            //     DropdownMenuItem(
            //       value: "1",
            //       child: Text(
            //         "Summitted",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "2",
            //       child: Text(
            //         "In Process",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "3",
            //       child: Text(
            //         "Incomplete",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "4",
            //       child: Text(
            //         "To be discussed",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "5",
            //       child: Text(
            //         "Done",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "6",
            //       child: Text(
            //         "Duplicate",
            //       ),
            //     ),
            //     DropdownMenuItem(
            //       value: "7",
            //       child: Text(
            //         "Obsolete",
            //       ),
            //     ),
            //   ],
            //   value: controller.selectedState.value.toString(),
            //   hint: Text('Select Task State'),
            //   isExpanded: true,
            //   onChanged: (selectedValue) {
            //     controller.selectedState.value =
            //         int.parse(selectedValue!);
            //   },
            // )),
            // SizedBox(
            //   height: 15,
            // ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                createOnPressed(nameController.text, contentController.text, projectId!);
              },
              child: Text(
                'Create',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
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
              onPressed: () {
                Get.back();
                updatePriorityOnPress(task,controller.selectedPriority.value);
                print(controller.selectedPriority.value);
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
      customSnackBar("Rename", "Success");
    } else {
      customSnackBar("Rename", "Some expected error happened");
    }
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
            )
          ],
        ),
        radius: 10.0);
  }
  void updateContent(Task task) {

  }

  Widget customBody() {
    if (!controller.isLastPage && controller.tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    var _items = controller.tasks;
    return LazyLoadScrollView(
        onEndOfPage: controller.nextPage,
        isLoading: controller.isLastPage,
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(15),
          iconColor: Colors.red,
          textColor: Colors.black54,
          tileColor: Colors.yellow[100],
          style: ListTileStyle.list,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          dense: true,
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(_items[index].name!),
                  subtitle: Text("Alo"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            // print(_textController.text);
                            updatePriorityDialog(_items[index]);
                            //
                            // nameController.text = "";
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
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
                                  bool rs = await controller
                                      .deleteTask(_items[index]);
                                  if (rs) {
                                    customSnackBar("Delete", "Success");
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
                      IconButton(
                          onPressed: () {
                            // print(_textController.text);
                            updateContent(_items[index]);
                            contentController.text = "";
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
