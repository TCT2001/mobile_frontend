// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_controller.dart';
import 'package:mobile_app/src/modules/task/task_project_page.dart';
import 'package:select_form_field/select_form_field.dart';

import 'project_controller.dart';

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

class ProjectDetailPage extends StatefulWidget {
  ProjectDetailPage({Key? key}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ProjectController controller = Get.put(ProjectController());
  TaskController taskController = Get.put(TaskController());
  int id = Get.arguments['id'];
  Project clickedProject = Get.arguments['clickedProject'];
  late Future<Project> project;
  late Future<List<Task>> tasks;
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  late TextEditingController invitedEmailController = TextEditingController();
  late TextEditingController newNameController = TextEditingController();
  late TextEditingController newContentController = TextEditingController();

  String invitedEmail = '';
  String role = '';
  String newTaskName = '';
  String newContentTask = '';

  @override
  void initState() {
    super.initState();
    project = controller.find(id);
    // tasks = taskController.list(id);
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('ProjectPage'),
      automaticallyImplyLeading: false,
      actionsIconTheme:
      IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      leading: GestureDetector(
        onTap: () {/* Write listener code here */
          Get.back();
          },
        child: Icon(
          Icons.arrow_back, // add custom icons also
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
              showInviteForm();
            } else if (value == 1) {
              showCreateTaskForm();
            }
            // else if (value == 2) {
            //   Get.defaultDialog(
            //     title: "Confirm",
            //     middleText: "Are your sure to delete ?",
            //     backgroundColor: Colors.white,
            //     titleStyle: const TextStyle(color: Colors.black),
            //     middleTextStyle: const TextStyle(color: Colors.black),
            //     actions: <Widget>[
            //       TextButton(
            //         child: const Text("Yes"),
            //         onPressed: () async {
            //           Get.back();
            //           bool rs = await controller.deleteProject(clickedProject);
            //           if (rs) {
            //             customSnackBar("Delete", "Success",
            //                 iconData: Icons.check_outlined,
            //                 iconColor: Colors.green);
            //           }
            //           Get.back();
            //           Get.back();
            //         },
            //       ),
            //       TextButton(
            //         child: const Text("No"),
            //         onPressed: () {
            //           Get.back();
            //         },
            //       ),
            //     ],
            //   );
            // }
          },
          key: _key,
          itemBuilder: (context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Invite'), value: 0),
              PopupMenuItem(child: Text('Create Task'), value: 1),
              //PopupMenuItem(child: Text('Delete Project'), value: 2),
            ];
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: FutureBuilder<Project>(
            future: project,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Container(child: showDetail(snapshot)),
                  Expanded(
                    child: Container(
                      child: showTaskList(snapshot.data)
                      // child: TaskProjectPage(project: snapshot.data!),
                    ),
                  )
                ],
              );
            }));
  }

  Widget showTaskList(Project? project) {
    if (project == null) {
      return Text("NULL");
    } else {
      return  TaskProjectPage(project: project);
    }
  }

  Widget showDetail(var snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!.toString());
    } else if (snapshot.hasError) {
      return Text('Loi');
    }
    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  }

  void showInviteForm() {
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

                          var temp = await controller.inviteProject(
                              srcEmail!, invitedEmail, id, role);
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

  void showCreateTaskForm() {
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
                      controller: newNameController,
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
                      controller: newContentController,
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
                          CommonResp? commonResp =
                              await taskController.createTask(
                                  newNameController.text,
                                  newContentController.text,
                                  id);
                          print(id);
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
}
