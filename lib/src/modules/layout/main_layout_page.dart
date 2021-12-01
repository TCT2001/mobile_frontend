// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/modules/feedback/feedback_window.dart';
import 'package:mobile_app/src/modules/home/home_page.dart';
import 'package:mobile_app/src/modules/layout/main_layout_controller.dart';
import 'package:mobile_app/src/modules/notification/noti_page.dart';
import 'package:mobile_app/src/modules/project/project_page.dart';
import 'package:mobile_app/src/modules/setting/setting_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile_app/src/modules/task/task_user_page.dart';

class MainLayoutPage extends GetView<MainLayoutController> {
  MainLayoutPage({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProjectPage(),
    TaskUserPage(),
    NotiPage(),
    SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    Get.put(MainLayoutController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() => _widgetOptions.elementAt(controller.index)),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Obx(() => GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 12,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: LineIcons.home, // cog
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.folder,
                      text: 'Project',
                    ),
                    GButton(
                      icon: LineIcons.tasks,
                      text: 'Tasks',
                    ),
                    GButton(
                      icon: LineIcons.bell,
                      text: 'Notifications',
                    ),
                    GButton(
                      icon: LineIcons.cog,
                      text: 'Settings',
                    ),
                  ],
                  selectedIndex: controller.index,
                  onTabChange: (index) {
                    controller.changeIndex(index);
                  },
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Feedback'),
        icon: Icon(Icons.report_gmailerrorred),
        onPressed: () {
          displayFeedbackWindow();
        },
      ),
    );
  }
}
