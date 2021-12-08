// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/core/utils/lazy_load_scroll_view.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/comment.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/task_service.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_user_controller.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({Key? key}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskUserController controller = Get.put(TaskUserController());

  int id = Get.arguments['id'];
  Task taskClicked = Get.arguments['task'];

  late Future<Task> task;
  late var userId;
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController invitedEmailController = TextEditingController();
  late TextEditingController newNameController = TextEditingController();
  late TextEditingController newContentController = TextEditingController();
  late TextEditingController newCommentController = TextEditingController();

  String newTaskName = '';
  String newContentTask = '';
  String comment = '';
  late Future<List<Comment>> listComment;

  @override
  void initState(){
    super.initState();
    // project = controller.find(id);
    task = controller.find(id);
    userId = getIntLocalStorge(LocalStorageKey.USER_ID.toString());
    listComment = TaskService.listComment(taskClicked.id!);

  }

  AppBar? taskDetailAppBar() {
    return AppBar(
      backgroundColor: Color(0xff2d5f79),
      title: Text('Task detail'),
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
              newNameController.text = "";
              Get.defaultDialog(
                  titleStyle: TextStyle(fontSize: 0),
                  title: 'Rename',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: newNameController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: 'New Name',
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
                          CommonResp? commonResp = await controller.renameTask(
                              taskClicked, newNameController.text);
                          if (commonResp == null) {
                            customSnackBar(
                                "Rename", "Some unexpected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            setState(() {
                              task = controller.find(id);
                            });
                            customSnackBar("Rename", "Success",
                                iconData: Icons.check_outlined,
                                iconColor: Colors.green);
                          } else {
                            customSnackBar(
                                "Rename", "Some unexpected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2d5f79),
                        ),
                        child: Text(
                          'Rename',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            } else if (value == 1) {
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
                              taskClicked,
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
                              await controller.updatePriority(taskClicked,
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
              newContentController.text = "";
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
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Rename Task'), value: 0),
              PopupMenuItem(child: Text('Update State'), value: 1),
              PopupMenuItem(child: Text('Update Priority'), value: 2),
              PopupMenuItem(child: Text('Update Content'), value: 3),
            ];
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: taskDetailAppBar(),
        body: Column(
          children: <Widget>[
            Container(
              child: FutureBuilder<Task>(
                future: task,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Task task = snapshot.data!;
                    int taskId = task.id!;
                    String taskName = task.name!;
                    String taskContent = task.content!;
                    String taskState = task.taskState!;
                    String taskPriority = task.priority!;
                    String taskDeadline = task.deadline!;
                    return Text(
                        "Id : $taskId\nName: $taskName\nContent : $taskContent \nState : $taskState\nPriority : $taskPriority\nDeadline: $taskDeadline",
                        style: TextStyle(fontSize: 20));
                  } else if (snapshot.hasError) {
                    return Text('Loi');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Expanded(child: FutureBuilder<List<Comment>>(
                future: listComment,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: Text("No Comment"));
                  }
                  var data = snapshot.data!;
                  data = data.reversed.toList();
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(right : 40),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return postComment(data[index].createdTime!, data[index].content!, data[index].userDTO!.email,
                            'https://lh3.googleusercontent.com/ogw/ADea4I41utR78MVuw5cnbm9nqhCOzg55A4fz6mA0qS1h=s83-c-mo');
                      });
                })),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller : newCommentController,
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
                          CommonResp? commonResp =
                          await controller.postComment(id, uId, comment);
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
                      child: const Text('Comment'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget postComment(String time, String postComment, String profileName,
      String profileImage) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              maxRadius: 16, backgroundImage: NetworkImage(profileImage)),
          SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: HexColor('#E9F1FE'),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          postComment,
                          style: TextStyle(fontSize: 12.5),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Text(time, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
