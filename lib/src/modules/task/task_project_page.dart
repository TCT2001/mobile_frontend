// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_project_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

Widget renameIconWidget(
    String role, Task task, var nameController, var controller) {
  if (role == "ADMINSTRATOR" || role == "OWNER") {
    return IconButton(
        onPressed: () {
          renameDialog(task, nameController, controller);
          nameController.text = task.name!;
        },
        icon: const Icon(Icons.edit, color: Colors.blue));
  }
  return const SizedBox.shrink();
}

Widget deleteIconWidget(String role, Task task, var controller) {
  if (role == "OWNER") {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () {
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
                bool rs = await controller.deleteTask(task);
                if (rs) {
                  customSnackBar("Delete", "Success",
                      iconData: Icons.check_outlined, iconColor: Colors.green);
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
    );
  }
  return const SizedBox.shrink();
}

Widget taskProjectList(Project project, var controller) {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');
  TextEditingController invitedEmailController =
      TextEditingController(text: '');
  TaskProjectController controller =
      Get.put(TaskProjectController(projectId: project.id!));

  return Obx(() {
    project.role = project.role!.toUpperCase();
    var _items = controller.tasks;

    if (controller.tasks.isEmpty) {
      // if (controller.isLastPage) {
      //   return Center(child: CircularProgressIndicator());
      // }
      return Center(child: Text("No task"));
    }
    return LazyLoadScrollView(
        onEndOfPage: controller.nextPage,
        isLoading: controller.isLastPage,
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(15),
          iconColor: Colors.black45,
          textColor: Colors.black,
          tileColor: Colors.white,
          style: ListTileStyle.list,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          dense: true,
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              Task task = _items[index];
              return GestureDetector(
                  onTap: () async {
                    String? ids = await getStringLocalStorge(
                        LocalStorageKey.RECENT_TASK.toString());
                    if (ids != null) {
                      var rs = ids.split("|");
                      if (rs.contains(_items[index].id.toString())) {
                        rs.remove(_items[index].id.toString());
                        if (rs.length >= 5) {
                          rs.removeAt(0);
                        }
                      }
                      rs.add(_items[index].id.toString());
                      ids = rs.join("|");
                    } else {
                      ids = "${_items[index].id}";
                    }
                    setStringLocalStorge(
                        LocalStorageKey.RECENT_TASK.toString(), "");
                    Get.toNamed(Routes.TASK_DETAIL_PAGE, arguments: {
                      "id": _items[index].id,
                      "task": _items[index]
                    });
                  },
                  child: buildCard(
                      task, project.role!, nameController, controller));
            },
          ),
        ));
  });
}

Card buildCard(Task task, String role, var nameController, var controller) {
  var subheading = task.name;
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        Container(
            margin: EdgeInsets.only(right: 20, top: 5, bottom: 0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Positioned(
                  //   left: 0,
                  //   child: Text("${task.briefContent}",
                  //       style: TextStyle(
                  //           fontSize: 18, fontWeight: FontWeight.bold)),
                  // ),
                  Container(
                    //color: HexColor("#1dd33f"),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: HexColor("#4fddd6"),
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(task.taskState!,
                        style: TextStyle(
                            color: HexColor("#352b2e"),
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: HexColor("#e8688e"),
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(task.priority!,
                        style: TextStyle(
                            color: HexColor("#352b2e"),
                            fontWeight: FontWeight.bold)),
                  ),
                ])),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            "${task.briefContent}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("\u{1F511}    $subheading"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              renameIconWidget(role, task, nameController, controller),
              deleteIconWidget(role, task, controller)
            ],
          ),
        ),
        Container(
            height: 15,
            margin: EdgeInsets.only(right: 20, bottom: 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ if (task.deadline != null) Text("Deadline: ${task.deadline!.substring(0, 10)}")
                            else Text ("Deadline: No set")]))
      ]));
}

void renameDialog(Task task, var nameController, var controller) {
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
              renameOnPressed(task, nameController.text, controller);
            },
            child: Text(
              'Rename',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff2d5f79))),
          )
        ],
      ),
      radius: 10.0);
}

void renameOnPressed(Task task, String newName, var controller) async {
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

void updateStateDialog(Task task, var controller) {
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
                      "Submitted",
                      // style: TextStyle(color: Color(0xffff0000)),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "IN_PROCESS",
                    child: Text(
                      "In process",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "INCOMPLETE",
                    child: Text(
                      "Incomplete",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "TO_BE_DISCUSSED",
                    child: Text(
                      "To be discussed",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Done",
                    child: Text(
                      "DONE",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "DUPLICATE",
                    child: Text(
                      "Duplicate",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "OBSOLETE",
                    child: Text(
                      "Obsolete",
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
                  task, controller.selectedState.value.toString(), controller);
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

void updateStateOnPress(Task task, String newState, var controller) async {
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

void updatePriorityDialog(Task task, var controller) {
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
                      "Critical",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "MAJOR",
                    child: Text(
                      "Major",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "NORMAL",
                    child: Text(
                      "Normal",
                    ),
                  ),
                  DropdownMenuItem(
                    value: "MINOR",
                    child: Text(
                      "Minor",
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
              updatePriorityOnPress(task,
                  controller.selectedPriority.value.toString(), controller);
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

void updatePriorityOnPress(
    Task task, String newPriority, var controller) async {
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

void updateContentDialog(Task task, var contentController, var controller) {
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
              updateContentOnPressed(task, contentController.text, controller);
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

void updateContentOnPressed(
    Task task, String newContent, var controller) async {
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
