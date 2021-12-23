// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = Get.arguments['email'];
  int id = Get.arguments['id'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d5f79),
        title: const Text('Profile'),
      ),
      backgroundColor: const Color(0xff88e8f2),
      body: SettingsList(sections: [
        SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Email',
                subtitle: email,
                //leading: const Icon(Icons.info),
              ),
              SettingsTile(
                title: 'Id',
                subtitle: id.toString(),
                //leading: const Icon(Icons.lightbulb),
              ),
            ])],
      ),
    );
  }
}