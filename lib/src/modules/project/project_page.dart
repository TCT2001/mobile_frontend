// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/services/project_service.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  ProjectPage({Key? key}) : super(key: key);

  TextEditingController renameController = TextEditingController(text: '');

  @override
  ProjectController controller = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProjectPage'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
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
                itemBuilder: (_, index) => Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(_items[index].name!),
                    subtitle: Text("Alo"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              // print(_renameController.text);
                              renameDialog(_items[index]);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
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
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
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

  void renameDialog(Project project) {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        title: 'Rename',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: renameController,
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
                renameOnPressed(project, renameController.text);
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
}
