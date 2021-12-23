// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/modules/setting/changepassword/changepassword_page.dart';
import 'package:mobile_app/src/modules/login/login_signup_page.dart';
import 'package:mobile_app/src/modules/setting/profile/profile_page.dart';
import 'package:settings_ui/settings_ui.dart';

import 'Instructions/instructions_page.dart';
import 'appinfo/app_info_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var userEmail;
  var userId;
  @override
  void initState() {
    super.initState();
    userEmail = getStringLocalStorge(LocalStorageKey.EMAIL.toString());
    userId = getIntLocalStorge(LocalStorageKey.USER_ID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Bg,
        appBar: AppBar(
          backgroundColor: Color(0xff2d5f79),
          title: Text("Setting"),
        ),
        body: Container(
            child: SettingsList(sections: [
          SettingsSection(
            title: 'Profile',
            tiles: [
              SettingsTile(
                title: 'User',
                leading: const Icon(Icons.manage_accounts),
                onPressed: (BuildContext context) async {
                  String email = await userEmail;
                  int id = await userId;
                  Get.to(ProfilePage(),
                      fullscreenDialog: true,
                      transition: Transition.cupertino,
                      duration: const Duration(seconds: 1),
                      arguments: {
                        "email" : email,
                        "id" : id
                      });
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'More about',
            tiles: [
              SettingsTile(
                title: 'App Info',
                leading: const Icon(Icons.info),
                onPressed: (BuildContext context) {
                  Get.to(AppInfoPage(),
                      fullscreenDialog: true,
                      transition: Transition.cupertino,
                      duration: const Duration(seconds: 1));
                },
              ),
              SettingsTile(
                title: 'Instructions',
                leading: const Icon(Icons.lightbulb),
                onPressed: (BuildContext context) {
                  Get.to(InstructionsPage(),
                      fullscreenDialog: true,
                      transition: Transition.cupertino,
                      duration: const Duration(seconds: 1));
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'General',
            tiles: [
              // SettingsTile(
              //   title: 'Language',
              //   subtitle: 'English',
              //   leading: const Icon(Icons.language),
              //   onPressed: (BuildContext context) {},
              // ),
              // SettingsTile.switchTile(
              //   switchActiveColor: Color(0xff2d5f79),
              //   title: 'Allow Notifications',
              //   leading: const Icon(Icons.notifications),
              //   switchValue: _a,
              //   onToggle: (bool value) {
              //     setState(() {
              //       _a = value;
              //     });
              //   },
              // ),
              // SettingsTile(
              //   title: 'App Info',
              //   leading: const Icon(Icons.info),
              //   onPressed: (BuildContext context) {
              //     // Get.to(AppInfoPage(),
              //     //     fullscreenDialog: true,
              //     //     transition: Transition.cupertino,
              //     //     duration: const Duration(seconds: 1));
              //   },
              // ),
              SettingsTile(
                title: 'Change Password',
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {
                  Get.to(ChangePasswordPage(),
                      fullscreenDialog: true,
                      transition: Transition.cupertino,
                      duration: const Duration(seconds: 1));
                },
              ),
              SettingsTile(
                title: 'Logout',
                leading: const Icon(Icons.logout),
                onPressed: (BuildContext context) {
                  cleanLocalStorage();
                  Get.offAll(const LoginScreen(),
                      fullscreenDialog: true,
                      transition: Transition.cupertino,
                      duration: const Duration(seconds: 1));
                },
              ),
            ],
          )
        ])));
  }
}
