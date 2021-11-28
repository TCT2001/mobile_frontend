// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_page.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  ProjectPage({Key? key}) : super(key: key);

  TextEditingController textController = TextEditingController(text: '');
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  ProjectController controller = Get.put(ProjectController());

  AppBar? projectAppBar() {
    return AppBar(
      title: const Text('ProjectPage'),
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
              textController.text = "";
            }
          },
          key: _key,
          itemBuilder: (context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Create project'), value: 0),
            ];
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(appBar: projectAppBar(), body: body()));
  }

  void deleteProject(Project project) {
    controller.projects.where((element) => project.id != element.id);
  }

  void renameOnPressed(Project project, String newName) async {
    CommonResp? commonResp = await controller.renameProject(project, newName);
    if (commonResp == null) {
      customSnackBar("Rename", "Some expected error happened",
          iconData: Icons.warning_rounded, iconColor: Colors.red);
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Rename", "Success",
          iconData: Icons.check_outlined, iconColor: Colors.green);
    } else {
      customSnackBar("Rename", "Some expected error happened",
          iconData: Icons.warning_rounded, iconColor: Colors.red);
    }
  }

  void createOnPressed(String newName) async {
    CommonResp? commonResp = await controller.createProject(newName);
    if (commonResp == null) {
      customSnackBar("Create", "Some expected error happened",
          iconData: Icons.warning_rounded, iconColor: Colors.red);
      return;
    }
    if (commonResp.code == "SUCCESS") {
      customSnackBar("Create", "Success",
          iconData: Icons.check_outlined, iconColor: Colors.green);
    } else {
      customSnackBar("Create", "Some expected error happened",
          iconData: Icons.warning_rounded, iconColor: Colors.red);
    }
  }

  void createDialog() {
    Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 0),
        title: 'Create',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                  labelText: 'Name',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4.0))),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                createOnPressed(textController.text);
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
  }

  void renameDialog(Project project) {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        title: 'Rename',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                  labelText: 'New Name',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4.0))),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                renameOnPressed(project, textController.text);
              },
              child: const Text(
                'Rename',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
  }

  Widget body() {
    if (controller.projects.isEmpty) {
      if (controller.isLastPage) {
        return Center(child: Text("No project"));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    var _items = controller.projects;
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
              Project project = _items[index];
              int id = project.id!;
              String name = project.name!;
              List<User> users = project.userDTOSet! as List<User>;

              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.TASK_PROJECT_PAGE,
                      arguments: {"project": _items[index]});
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Id: $id, Name: $name, Users: $users"),
                    subtitle: Text("Co gi khong"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              renameDialog(_items[index]);
                              textController.text = "";
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
                                        .deleteProject(_items[index]);
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
