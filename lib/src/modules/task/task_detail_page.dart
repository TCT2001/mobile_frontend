// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/comment.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/task_service.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_user_controller.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({Key? key}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskUserController controller = Get.put(TaskUserController());

  int id = Get.arguments['id'];
  Task taskClicked = Get.arguments['task'];
  late Future<Task> task;
  late var userId;
  late Future<List<Comment>> listComment;
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController invitedEmailController = TextEditingController();
  late TextEditingController newNameController = TextEditingController();
  late TextEditingController newContentController = TextEditingController();
  late TextEditingController newCommentController = TextEditingController();

  String newTaskName = '';
  String newContentTask = '';
  String comment = '';
  @override
  void initState() {
    super.initState();
    // project = controller.find(id);
    task = controller.find(id);
    userId = getIntLocalStorge(LocalStorageKey.USER_ID.toString());
    listComment = TaskService.listComment(Task.id(id: id).id!);
  }

  AppBar? taskDetailAppBar(String role) {
    return AppBar(
      backgroundColor: Color(0xff2d5f79),
      title: Text(taskClicked.name!),
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back, // add custom icons also
        ),
      ),
      actionsIconTheme:
          IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 1) {
              controller.selectedState.value = taskClicked.taskState!;
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
                          CommonResp? commonResp = await controller.updateState(
                              Task.id(id: id),
                              controller.selectedState.value.toString());
                          if (commonResp == null) {
                            customSnackBar(
                                "Update State", "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            setState(() {
                              task = controller.find(id);
                            });
                            customSnackBar("Update State", "Success",
                                iconData: Icons.check_outlined,
                                iconColor: Colors.green);
                          } else {
                            customSnackBar(
                                "Update State", "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2d5f79),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            } else if (value == 2) {
              controller.selectedPriority.value = taskClicked.priority!;
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
                              controller.selectedPriority.value =
                                  selectedValue!;
                            },
                          )),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp =
                              await controller.updatePriority(Task.id(id: id),
                                  controller.selectedPriority.value.toString());
                          if (commonResp == null) {
                            customSnackBar("Update Priority",
                                "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            setState(() {
                              task = controller.find(id);
                            });
                            customSnackBar("Update Priority", "Success",
                                iconData: Icons.check_outlined,
                                iconColor: Colors.green);
                          } else {
                            customSnackBar("Update Priority",
                                "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2d5f79),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            } else if (value == 3) {
              newContentController.text = taskClicked.content!;
              Get.defaultDialog(
                  titleStyle: TextStyle(fontSize: 0),
                  title: 'Update Content',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: newContentController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: 'New Content',
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 4.0))),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          CommonResp? commonResp =
                              await controller.updateContent(
                                  taskClicked, newContentController.text);
                          if (commonResp == null) {
                            customSnackBar("UpdateContent",
                                "Some unexpected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            setState(() {
                              task = controller.find(id);
                            });
                            customSnackBar("Update Content", "Success",
                                iconData: Icons.check_outlined,
                                iconColor: Colors.green);
                          } else {
                            customSnackBar("Update Content",
                                "Some unexpected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2d5f79),
                        ),
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
            return listAppbar(role);
          },
        ),
      ],
    );
  }

  List<PopupMenuEntry<int>> listAppbar(String role) {
    if (role == "OWNER") {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Update State'), value: 1),
        PopupMenuItem(child: Text('Update Priority'), value: 2),
        PopupMenuItem(child: Text('Update Content'), value: 3),
      ];
    } else if (role == "ADMINISTRATOR") {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Update State'), value: 1),
        PopupMenuItem(child: Text('Update Priority'), value: 2),
        PopupMenuItem(child: Text('Update Content'), value: 3),
      ];
    } else if (role == "MEMBER") {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Update State'), value: 1),
      ];
    } else {
      return List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Task>(
        future: task,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          Task task = snapshot.data!;
          String role = task.project!.role!;
          return Scaffold(
              backgroundColor: Bg,
              appBar: taskDetailAppBar(role),
              body: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: mainCard(task),
                  ),
                  Text(
                    "Comment",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Expanded(
                      child: FutureBuilder<List<Comment>>(
                          future: listComment,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Center(child: Text("No Comment"));
                            }
                            var data = snapshot.data!;
                            data = data.reversed.toList();
                            return ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(right: 40),
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // print(data[index].id);
                                  final id = 48693 - data[index].id! * 45 % 300;
                                  final hexString = id.toRadixString(16);
                                  return postComment(
                                      data[index].createdTime!.substring(0, 10),
                                      data[index].content!,
                                      data[index].userDTO!.email,
                                      "https://ui-avatars.com/api/?name=${data[index].userDTO!.email}&background=$hexString");
                                });
                          })),
                  Container(
                    margin: EdgeInsets.only(left: 18, right: 18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: newCommentController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  comment = newCommentController.text;
                                  int uId = await userId;
                                  CommonResp? commonResp = await controller
                                      .postComment(id, uId, comment);
                                  if (commonResp!.code == "SUCCESS") {
                                    customSnackBar("Comment", "Success",
                                        iconData: Icons.check_outlined,
                                        iconColor: Colors.green);
                                  } else {
                                    customSnackBar("Comment", "Fail",
                                        iconData: Icons.warning_rounded,
                                        iconColor: Colors.red);
                                  }
                                  newCommentController.clear();
                                  setState(() {
                                    listComment = TaskService.listComment(id);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff2d5f79),
                              ),
                              child: const Text('Comment'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //ListView.builder(itemBuilder: itemBuilder)
                ],
              ));
        });
  }

  Widget mainCard(Task task) {
    String deadline =
        task.deadline == null ? "Not set" : task.deadline!.substring(0, 10);
    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Deadline: $deadline", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Container(
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
                  ]),
            ),
            ListTile(
                title: Text(
                    task.content!,
                    style: TextStyle(fontSize: 16))),
          ],
        ));
  }

  Widget postComment(String time, String postComment, String profileName,
      String profileImage) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              maxRadius: 16, backgroundImage: NetworkImage(profileImage)),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          postComment,
                          style: TextStyle(fontSize: 16.0),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(time, style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
