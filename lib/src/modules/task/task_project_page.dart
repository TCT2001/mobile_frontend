// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/project/project_controller.dart';
import 'package:mobile_app/src/modules/project/project_page.dart';
import 'package:mobile_app/src/modules/task/task_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import 'package:select_form_field/select_form_field.dart';

import 'task_project_controller.dart';

//Ai list cai task thi` moi test dc het nhe' :( toi chua hien dc list =)) tinh nang toi test tam cai branch cua? toan` co ve? dc roi`

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

class TaskProjectPage extends GetView<TaskProjectController> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');
  TextEditingController invitedEmailController =
      TextEditingController(text: '');

  Project project;

  TaskProjectPage({Key? key, required this.project}) : super(key: key);

  String invitedEmail = '';
  String role = '';

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  ProjectController projController = Get.put(ProjectController());

  AppBar? taskAppBar() {
    return AppBar(
      title: Text('Tasks of project'),
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          //Ban sua giup toi =)) toi chi dua ve dc HOME hoac neu ve PROJECT thi toi mat Navbar
          Get.offAllNamed(Routes.MAIN);
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
                        decoration: const InputDecoration(
                            labelText: 'New Name',
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 4.0))),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp = await projController
                              .renameProject(project, nameController.text);
                          if (commonResp == null) {
                            customSnackBar(
                                "Rename", "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            customSnackBar("Rename", "Success",
                                iconData: Icons.check_outlined,
                                iconColor: Colors.green);
                          } else {
                            customSnackBar(
                                "Rename", "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                          }
                        },
                        child: const Text(
                          'Rename',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            } else if (value == 1) {
              Get.defaultDialog(
                title: "Confirm",
                middleText: "Are your sure to delete ?",
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.black),
                middleTextStyle: const TextStyle(color: Colors.black),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () async {
                      Get.back();
                      bool rs = await projController.deleteProject(project);
                      if (rs) {
                        customSnackBar("Delete", "Success",
                            iconData: Icons.check_outlined,
                            iconColor: Colors.green);
                      }
                      //Ban sua giup toi neu xoa ve luon PROJECT dep nhe =)) toi chi dua ve dc HOME hoac neu ve PROJECT thi toi mat Navbar
                      Get.offAllNamed(Routes.MAIN);
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
            } else if (value == 2) {
              inviteDialog();
            } else if (value == 3) {
              createDialog();
              nameController.text = "";
              contentController.text = "";
            }
          },
          key: _key,
          itemBuilder: (context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Rename project'), value: 0),
              PopupMenuItem(child: Text('Delete project'), value: 1),
              PopupMenuItem(child: Text('Invite'), value: 2),
              PopupMenuItem(child: Text('Create task'), value: 3),
            ];
          },
        ),
      ],
    );
  }

  void inviteDialog() {
    Get.bottomSheet(
      Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            // color: Colors.white,
            color: Color(0xff88e8f2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invite',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: invitedEmailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown, // or can be dialog
                      initialValue: 'circle',
                      icon: Icon(Icons.format_shapes),
                      labelText: 'Role',
                      items: _items,
                      onChanged: (val) {
                        role = val;
                      },
                      onSaved: (val) => print(val),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: const Text('Invite'),
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          invitedEmail = invitedEmailController.text;
                          //TODO
                          if (!EmailValidator.validate(invitedEmail)) {
                            customSnackBar("Email", "error");
                            return;
                          }

                          var srcEmail = await getStringLocalStorge(
                              LocalStorageKey.EMAIL.toString());

                          var temp = await projController.inviteProject(
                              srcEmail!, invitedEmail, project.id, role);
                          if (temp!.code == "SUCCESS") {
                            customSnackBar('Invite', "Success");
                            Get.back();
                          } else {
                            customSnackBar("Invite", temp.data as String);
                          }
                          invitedEmailController.clear();
                        })
                  ],
                )
              ],
            ),
          )),
    );
  }

  void createDialog() {
    Get.bottomSheet(
      Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            // color: Colors.white,
            color: Color(0xff88e8f2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Task',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        hintText: 'Content',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: const Text('Create'),
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          //TODO
                          Get.back();
                          CommonResp? commonResp = await controller.createTask(
                              nameController.text,
                              contentController.text,
                              project.id);
                          if (commonResp!.code == "SUCCESS") {
                            customSnackBar("Create Task", "Success");
                          } else {
                            customSnackBar("Create Task", "Fail");
                          }
                        })
                  ],
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => customBody());
  }

  Widget customBody() {
    TaskProjectController controller =
        Get.put(TaskProjectController(projectId: project.id!));
    //controller.listTaskOfProject(project.id!);
    if (controller.tasks.isEmpty) {
      if (controller.isLastPage) {
        return Center(child: Text("No task"));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    var _items = controller.tasks;
    // return Text("321");
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
            itemBuilder: (_, index) {
              Task task = _items[index];
              // int id = task.id!;
              // String content = task.content!;
              // String name = task.name!;
              // String visibleTaskScope = task.visibleTaskScope!;
              // String priority = task.priority!;
              // int userIdIfVisibleIsPrivate = task.userIdIfVisibleIsPrivate!;
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.TASK_DETAIL_PAGE,
                      arguments: {"task": _items[index]});
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(task.toString()),
                    subtitle: Text("Chua biet"),
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

  void updateStateDialog(Task task) {
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
