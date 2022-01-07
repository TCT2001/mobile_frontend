// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:date_format/date_format.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/core/utils/url_link_utils.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/user.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_project_controller.dart';
import 'package:mobile_app/src/modules/task/task_project_page.dart';
import 'package:select_form_field/select_form_field.dart';

import 'piechart/piechart_page.dart';
import 'project_controller.dart';

final List<Map<String, dynamic>> _items = [
  {
    'value': 'ADMINISTRATOR',
    'label': 'Admin',
    'icon': Icon(Icons.admin_panel_settings),
  },
  {
    'value': 'MEMBER',
    'label': 'Member',
    'icon': Icon(Icons.remember_me),
  },
  {
    'value': 'OBSERVER',
    'label': ' Observer',
    'icon': Icon(Icons.remove_red_eye),
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
  late Future<Project> project;
  final GlobalKey<ScaffoldState> _keyDraw = GlobalKey(); // Create a key
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController invitedEmailController = TextEditingController();
  late TextEditingController newNameController = TextEditingController();
  late TextEditingController newContentController = TextEditingController();
  TextEditingController searchController = TextEditingController(text: '');
  late String? sortValue = "Deadline";
  String invitedEmail = '';
  String role = '';
  String newTaskName = '';
  String newContentTask = '';
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  String projectName = '';
  var deadline;
  var userEmail;
  String? userEmailString;

  @override
  void initState() {
    super.initState();
    project = controller.find(id);
    userEmail = getStringLocalStorge(LocalStorageKey.EMAIL.toString());
  }

  AppBar appBar(String role, BuildContext context, int projectId, String name,
      var project) {
    return AppBar(
      title: Text("Detail"),
      automaticallyImplyLeading: false,
      actionsIconTheme:
          IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      backgroundColor: Color(0xff2d5f79),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
        ),
      ),
      actions: <Widget>[
        // Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Icon(
        //         Icons.search,
        //         size: 26.0,
        //       ),
        //     )),
        PopupMenuButton<int>(
          onSelected: (value) async {
            userEmailString = await userEmail;
            if (value == 0) {
              newNameController.text = "";
              newContentController.text = "";
              showInviteForm();
            } else if (value == 1) {
              showCreateTaskForm();
            } else if (value == 2) {
              newNameController.text = name;
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
                      bool rs = await controller.deleteProject(project);
                      if (rs) {
                        Get.back();
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
            } else if (value == 5) {
              Get.to(() => PiechartPage(id: projectId));
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
        PopupMenuItem(child: Text('Info'), value: 4),
        PopupMenuItem(child: Text('Statistics'), value: 5)
      ];
    } else if (role == "ADMINISTRATOR") {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Invite'), value: 0),
        PopupMenuItem(child: Text('Create Task'), value: 1),
        PopupMenuItem(child: Text('Rename Project'), value: 2),
        PopupMenuItem(child: Text('Info'), value: 4),
        PopupMenuItem(child: Text('Statistics'), value: 5)
      ];
    } else {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(child: Text('Info'), value: 4)
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
            backgroundColor: Bg,
            key: _keyDraw,
            drawer: drawer(snapshot.data!.userDTOSet!, snapshot.data!),
            appBar: appBar(snapshot.data!.role!, context, snapshot.data!.id!,
                snapshot.data!.name!, snapshot.data!),
            body: Column(
              children: <Widget>[
                // Center(child: Text(snapshot.data!.name!, style: TextStyle(fontSize: 20),)),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.search), hintText: "Enter for search"),
                    onChanged: (String? value) {
                      taskProjectController.searchByName(value!);
                      controller.update();
                    },
                  ),
                ),
                Expanded(
                    child: showTaskList(snapshot.data, taskProjectController))
              ],
            ),
          );
        });
  }

  Widget drawer(List members, Project project) {
    members = members as List<User>;
    Future<void>? _launched;
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Bg,
            ),
            child: Column(
              children: [
                Text("Project: ${project.name}",
                    style: TextStyle(fontSize: 30)),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                "Members",
                style: TextStyle(fontSize: 18),
              )),
          SizedBox(
              height: double.maxFinite,
              child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (BuildContext context, i) {
                    final id = 48693 - members[i].id * 45 % 300 as int;
                    final hexString = id.toRadixString(16);
                    final email = members[i].getEmail().substring(7);
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email);
                    bool isMeBool = userEmailString == email;
                    return Card(
                        color: Bg,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Image.network(
                                    "https://ui-avatars.com/api/?name=${members[i].email}&background=$hexString"),
                              ),
                              title: Text(email),
                              subtitle: Text(members[i].getRole()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  deleteIconWidget(project.role!, project,
                                      isMeBool, members[i].id, email)
                                ],
                              ),
                            ),
                            contactIcon(emailValid, isMeBool, _launched, email)
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

  Widget deleteIconWidget(
      var role, Project projectIn, var isMeBool, var userId, var email) {
    if (role == "OWNER" && !isMeBool) {
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
                  bool rs = await controller.deleteUserFromProject(
                      userId, projectIn.id!, email);
                  if (rs) {
                    setState(() {
                      project = controller.find(projectIn.id!);
                    });
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

  Widget contactIcon(bool isEmail, bool isMeBool, var _launched, var email) {
    if (isMeBool) {
      return Text("It's me");
    }
    if (isEmail) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _launched = makeEmail(email, "subject", "body");
            },
            child: Icon(
              Icons.email,
              size: 30,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                _launched = makePhoneCall(email);
              },
              child: Icon(Icons.local_phone, size: 30)),
          SizedBox(width: 20),
          GestureDetector(
              onTap: () {
                _launched = makePhoneCall(email);
              },
              child: Icon(Icons.sms, size: 30))
        ],
      );
    }
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
                      type: SelectFormFieldType.dropdown,
                      initialValue: 'circle',
                      icon: Icon(Icons.flutter_dash_rounded),
                      labelText: 'Role',
                      items: _items,
                      onChanged: (val) {
                        role = val;
                      },
                      onSaved: (val) {
                        //Save
                      },
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
                          if (!EmailValidator.validate(invitedEmail)) {
                            customSnackBar("Email", "Email is not valid",
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
                            customSnackBar("Error", temp.data as String,
                                iconData: Icons.warning_rounded,
                                iconColor: Colors.red);
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
    newNameController.clear();
    newContentController.clear();
    taskController.selectedScope = "PUBLIC".obs;
    taskController.selectedPriority = "NORMAL".obs;
    taskController.selectedState = "SUBMITTED".obs;
    selectedDate = DateTime.now().add(Duration(days: 1));
    Get.bottomSheet(
      Container(
          height: 850,
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 0,
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
                        height: 6,
                      ),
                      TextFormField(
                        minLines: 5,
                        maxLines: 10,
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
                        height: 4,
                      ),
                      Text("Select Task State"),
                      Obx(() => DropdownButton<String>(
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
                            value:
                                taskController.selectedState.value.toString(),
                            hint: const Text('Select Task State'),
                            isExpanded: true,
                            onChanged: (selectedValue) {
                              taskController.selectedState.value =
                                  selectedValue!;
                            },
                          )),
                      const SizedBox(
                        height: 4,
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
                            value: taskController.selectedPriority.value
                                .toString(),
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
                            height: 1,
                            width: 150,
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
                        height: 0,
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
                                    iconColor: Colors.white);
                              } else {
                                customSnackBar("Create Task", "Fail",
                                    iconData: Icons.warning_rounded,
                                    iconColor: Colors.red);
                              }
                            }
                          })
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
