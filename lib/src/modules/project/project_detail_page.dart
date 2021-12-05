// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:date_format/date_format.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_project_controller.dart';
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
  int id = Get.arguments['id'];
  Project clickedProject = Get.arguments['clickedProject'];
  late Future<Project> project;
  final GlobalKey<ScaffoldState> _keyDraw = GlobalKey(); // Create a key
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController invitedEmailController = TextEditingController();
  late TextEditingController newNameController = TextEditingController();
  late TextEditingController newContentController = TextEditingController();

  String invitedEmail = '';
  String role = '';
  String newTaskName = '';
  String newContentTask = '';
  DateTime selectedDate = DateTime.now();
  var deadline;

  @override
  void initState() {
    super.initState();
    project = controller.find(id);
  }

  AppBar appBar(String role, BuildContext context) {
    return AppBar(
      title: const Text('ProjectDetailPage'),
      automaticallyImplyLeading: false,
      actionsIconTheme:
          IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      backgroundColor: Color(0xff2d5f79),
      leading: GestureDetector(
        onTap: () {
          //TODO
          /* Write listener code here */
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
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
              newNameController.text = "";
              newContentController.text = "";
              showInviteForm();
            } else if (value == 1) {
              showCreateTaskForm();
            } else if (value == 2) {
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
                          CommonResp? commonResp =
                              await controller.renameProject(
                                  Project.id(id: id), newNameController.text);
                          if (commonResp == null) {
                            customSnackBar(
                                "Rename", "Some expected error happened",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }
                          if (commonResp.code == "SUCCESS") {
                            setState(() {
                              project = controller.find(id);
                            });
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
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2d5f79),
                        ),
                        child: const Text(
                          'Rename',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            } else if (value == 3) {
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
                      bool rs = await controller.deleteProject(clickedProject);
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
            } else if (value == 4) {
              _keyDraw.currentState!.openDrawer();
            }
          },
          key: _key,
          itemBuilder: (context) {
            return listAppbar(role.toUpperCase());
          },
        ),
      ],
    );
  }

  List<PopupMenuEntry<int>> listAppbar(String role) {
    if (role == "OWNER") {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Invite'), value: 0),
        PopupMenuItem(child: Text('Create Task'), value: 1),
        PopupMenuItem(child: Text('Rename Project'), value: 2),
        PopupMenuItem(child: Text('Delete Project'), value: 3),
        PopupMenuItem(child: Text('Members'), value: 4)
      ];
    } else if (role == "ADMINISTRATOR") {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Invite'), value: 0),
        PopupMenuItem(child: Text('Create Task'), value: 1),
        PopupMenuItem(child: Text('Rename Project'), value: 2),
        PopupMenuItem(child: Text('Members'), value: 4),
      ];
    } else {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Members'), value: 4)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    TaskProjectController taskProjectController =
        Get.put(TaskProjectController(projectId: id));

    return FutureBuilder<Project>(
        future: project,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            key: _keyDraw,
            drawer: drawer(snapshot.data!.userDTOSet!),
            appBar: appBar(snapshot.data!.role!, context),
            body: Column(
              children: <Widget>[
                Container(child: showDetail(snapshot)),
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                  ),
                  onChanged: (String? value) {
                    taskProjectController.searchByName(value!);
                    controller.update();
                  },
                ),
                Expanded(
                    child: Container(
                        child:
                            showTaskList(snapshot.data, taskProjectController)))
              ],
            ),
          );
        });
  }

  Widget drawer(List members) {
    members = members as List<User>;
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("Members in project"),
          ),
          Container(
              height: double.maxFinite,
              child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (BuildContext context, i) {
                    final id = members[i].id % 256 + 256;
                    final hexString = id.toRadixString(16);
                    return Card(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(
                                "https://ui-avatars.com/api/?name=${members[i].email}&color=$hexString"),
                          ),
                          title: Text(members[i].toString()),
                          subtitle: Text('TWICE'),
                        ),
                      ],
                    ));
                  })),
          // ListTile(
          //   title: const Text('Close'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }

  Widget showTaskList(Project? project, var taskProjectController) {
    if (project == null) {
      return Text("NULL");
    } else {
      return taskProjectList(project, taskProjectController);
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
                        backgroundColor: Color(0xff2d5f79),
                        label: const Text('Invite'),
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          invitedEmail = invitedEmailController.text;
                          //TODO
                          if (!EmailValidator.validate(invitedEmail)) {
                            customSnackBar("Email", "error",
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
                            return;
                          }

                          var srcEmail = await getStringLocalStorge(
                              LocalStorageKey.EMAIL.toString());

                          var temp = await controller.inviteProject(
                              srcEmail!, invitedEmail, id, role);
                          if (temp!.code == "SUCCESS") {
                            customSnackBar('Invite', "Success",
                                iconData: Icons.check_outlined,
                                iconColor: Colors.green);
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
    TaskProjectController taskController =
        Get.put(TaskProjectController(projectId: id));
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Task',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: newNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter task name';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter task content';
                        }
                        return null;
                      },
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
                    Text("Select Task State"),
                    Obx(() => DropdownButton<String>(
                          // Set the Items of DropDownButton
                          items: const [
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
                          value: taskController.selectedState.value.toString(),
                          hint: const Text('Select Task State'),
                          isExpanded: true,
                          onChanged: (selectedValue) {
                            taskController.selectedState.value = selectedValue!;
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Select Task Priority"),
                    Obx(() => DropdownButton<String>(
                          // Set the Items of DropDownButton
                          items: const [
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
                          value:
                              taskController.selectedPriority.value.toString(),
                          hint: const Text('Select Task Priority'),
                          isExpanded: true,
                          onChanged: (selectedValue) {
                            taskController.selectedPriority.value =
                                selectedValue!;
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Select Task Deadline"),
                        const SizedBox(
                          width: 175,
                        ),
                        IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                                helpText: 'Select task deadline',
                                errorFormatText: 'Enter valid date',
                                errorInvalidText: 'Enter date in valid range',
                              );
                              if (picked != null) {
                                selectedDate = picked;
                              }
                              deadline = formatDate(
                                  selectedDate, [yyyy, '-', mm, '-', dd]);
                            },
                            icon: const Icon(Icons.calendar_today_outlined)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        backgroundColor: Color(0xff2d5f79),
                        label: const Text('Create'),
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Get.back();
                            CommonResp? commonResp =
                                await taskController.createTask(
                                    newNameController.text,
                                    newContentController.text,
                                    taskController.selectedState.value,
                                    taskController.selectedPriority.value,
                                    deadline.toString(),
                                    id);
                            if (commonResp!.code == "SUCCESS") {
                              customSnackBar("Create Task", "Success",
                                  iconData: Icons.check_outlined,
                                  iconColor: Colors.green);
                            } else {
                              customSnackBar("Create Task", "Fail",
                                  iconData: Icons.warning_rounded,
                                  iconColor: Colors.red);
                            }
                            newNameController.clear();
                            newContentController.clear();
                            taskController.selectedScope = "PUBLIC".obs;
                            taskController.selectedPriority = "NORMAL".obs;
                            taskController.selectedState = "SUBMITTED".obs;
                            selectedDate = DateTime.now();
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
