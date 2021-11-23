// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_page.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  ProjectPage({Key? key}) : super(key: key);

  TextEditingController textController = TextEditingController(text: '');
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  ProjectController controller = Get.put(ProjectController());

  AppBar? projectAppBar() {
    if (controller.choice == 0) {
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
                PopupMenuItem(child: Text('Create'), value: 0),
              ];
            },
          ),
        ],
      );
    // } else if (controller.choice == 1) {
    //   return AppBar(
    //     title: Text('Tasks in project'),
    //     automaticallyImplyLeading: false,
    //     leading: GestureDetector(
    //       onTap: () {
    //         controller.changeChoice(0, null);
    //       },
    //       child: Icon(
    //         Icons.arrow_back, // add custom icons also
    //       ),
    //     ),
    //     actionsIconTheme:
    //         IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
    //     actions: <Widget>[
    //       Padding(
    //           padding: EdgeInsets.only(right: 20.0),
    //           child: GestureDetector(
    //             onTap: () {},
    //             child: Icon(
    //               Icons.search,
    //               size: 26.0,
    //             ),
    //           )),
    //       PopupMenuButton<int>(
    //         onSelected: (value) {
    //           if (value == 0) {
    //             // createDialog();
    //             textController.text = "";
    //           }
    //         },
    //         key: _key,
    //         itemBuilder: (context) {
    //           return <PopupMenuEntry<int>>[
    //             PopupMenuItem(child: Text('Create'), value: 0),
    //           ];
    //         },
    //       ),
    //     ],
    //   );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(appBar: projectAppBar(), body: customBody()));
  }

  Widget customBody() {
    if (controller.choice == 1) {
      return bodyChoiceOne();
    } else {
      return bodyChoiceZero();
    }
  }

  void deleteProject(Project project) {
    controller.projects.where((element) => project.id != element.id);
  }

  void renameOnPressed(Project project, String newName) async {
    CommonResp? commonResp = await controller.renameProject(project, newName);
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

  void createOnPressed(String newName) async {
    CommonResp? commonResp = await controller.createProject(newName);
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

  void createDialog() {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        title: 'Create',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Name',
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
                createOnPressed(textController.text);
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
                renameOnPressed(project, textController.text);
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

  Widget bodyChoiceZero() {
    if (!controller.isLastPage && controller.projects.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
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
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                controller.changeChoice(1, _items[index]);
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget bodyChoiceOne() {
    Project clickedProjectCard = controller.clickedProjectCard;
    int? id = clickedProjectCard.id;
    String? name = clickedProjectCard.name;
    return TaskPage.ofProject(projectId: id);
  }
}
