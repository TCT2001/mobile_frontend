// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

import 'project_controller.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  TextEditingController searchController = TextEditingController(text: '');
  TextEditingController textController = TextEditingController(text: '');
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  ProjectController controller = Get.put(ProjectController());
  late String? sortValue = "Deadline";

  Widget sort() {
    return DropdownButton<String>(
      items: const [
        DropdownMenuItem<String>(
          child: Text('⏰ Deadline'),
          value: 'Deadline',
        ),
        DropdownMenuItem<String>(
          child: Text('      ASC'),
          value: 'ASC',
        ),
        DropdownMenuItem<String>(
          child: Text('      DESC'),
          value: 'DESC',
        ),
      ],
      onChanged: (String? value) {
        var a = value == "ASC";
        controller.sort("deadline", a);
        setState(() {
          sortValue = value;
        });
      },
      value: sortValue,
    );
  }

  AppBar? projectAppBar(BuildContext context) {
    return AppBar(
      title: const Text('ProjectPage'),
      automaticallyImplyLeading: false,
      actionsIconTheme:
      IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      leading: GestureDetector(
        onTap: () {
          /* Write listener code here */
        },
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
      actions: <Widget>[
        // Container(
        //     width: 120,
        //     child: TextField(
        //       controller: searchController,
        //       decoration: const InputDecoration(
        //         icon: Icon(Icons.search, color: Color(0xffffffff),),
        //       ),
        //
        //       onChanged: (String? value) {
        //         controller.searchByName(value!);
        //         controller.update();
        //       },
        //     )),
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
              PopupMenuItem(
                child: Text('☕ Create project'),
                value: 0,
              ),
            ];
          },
        ),
      ],
      backgroundColor: Color(0xff2d5f79),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Bg,
        appBar: projectAppBar(context),
        body: Column(
          children: <Widget>[
            Container(
              child: sort(),
            ),
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
            Expanded(child: body()
              // child: Container(
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image:
              //                 Image.asset("assets/images/background.jpg").image,
              //             fit: BoxFit.cover)),
              //     child: body()),
            )
          ],
        ));
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
              style: ElevatedButton.styleFrom(primary: Color(0xff2d5f79)),
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
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff2d5f79))),
            )
          ],
        ),
        radius: 10.0);
  }

  Widget body() {
    return Obx(() {
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
            iconColor: Colors.black45,
            textColor: Colors.black,
            tileColor: Colors.white,
            style: ListTileStyle.list,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            //dense: true,
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                Project project = _items[index];
                int id = project.id!;
                String name = project.name!;
                String role = project.role!;
                List<User> users = project.userDTOSet! as List<User>;
                var rs = users.where((e) => e.role == 'OWNER');
                var boss = rs.first;
                int number = project.userDTOSet!.length;
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
                      "id": _items[index].id,
                      "clickedProject": _items[index]
                    });
                  },
                  child: buildCard(project, boss, users),
                  // child: Card(
                  //   color: BathWater,
                  //   margin: const EdgeInsets.all(10),
                  //   child: ListTile(
                  //     title: Text("☕ Project: $name"),
                  //     subtitle: Text(
                  //         "\n📜 Role: $role\n      Owner: ${boss.email} \n      Team's number: $number"),
                  //     trailing: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         renameIconWidget(_items[index].role!, _items[index]),
                  //         deleteIconWidget(_items[index].role!, _items[index])
                  //       ],
                  //     ),
                  //   ),
                  // ),
                );
              },
            ),
          ));
    });
  }

  Widget renameIconWidget(String role, Project project) {
    if (role == "ADMINISTRATOR" || role == "OWNER") {
      return IconButton(
          onPressed: () {
            renameDialog(project);
            textController.text = "";
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.blue,
          ));
    }
    return const SizedBox.shrink();
  }

  Widget deleteIconWidget(String role, Project project) {
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
                  bool rs = await controller.deleteProject(project);
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
      );
    }
    return const SizedBox.shrink();
  }

  Card buildCard(Project project, User owner, List<User> list) {
    var heading = project.name!;
    var subheading = owner.email;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              "\u{1F4D1}  $heading",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("\u{1F511}    $subheading"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                renameIconWidget(project.role!, project),
                deleteIconWidget(project.role!, project)
              ],
            ),
          ),
          Container(
            height: 35,
            margin: EdgeInsets.only(right: 10),
            child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length > 5 ? 5 : list.length,
                itemBuilder: (_, index) {
                  final id = list[index].id % 256 + 256;
                  final hexString = id.toRadixString(16);
                  return Image.network(
                      "https://ui-avatars.com/api/?name=${list[index].email}&color=$hexString");
                }),
          ),
        ]));
  }
}