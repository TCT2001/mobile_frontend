import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/models/project.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProjectPage')),
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
                    title: Text(_items[index].name),
                    subtitle: Text("Alo"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
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
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteProject(_items[index]);
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
                              print(_items[index]);
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
}