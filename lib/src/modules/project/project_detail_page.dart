import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/project.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'package:mobile_app/src/modules/task/task_controller.dart';
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
  late Future<Project> project;
  late Future<List<Task>> tasks;
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  late TextEditingController invitedEmailController = TextEditingController();
  String invitedEmail = '';
  String role = '';
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
              showInviteForm();
            }
          },
          key: _key,
          itemBuilder: (context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(child: Text('Invite'), value: 0),
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
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else if (snapshot.hasError) {
              return Text('Loi');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
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
                          print(invitedEmail);
                          print(role);
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
}
