// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:settings_ui/settings_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var userEmail;
  var Id;
  @override
  void initState() {
    super.initState();
    userEmail = getIntLocalStorge(LocalStorageKey.EMAIL.toString());
    Id = getIntLocalStorge(LocalStorageKey.USER_ID.toString());

  }



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
            tiles: const [
              SettingsTile(
                title: 'Email',
                // subtitle: const Text('$userEmail'),
                //leading: const Icon(Icons.info),
              ),
              SettingsTile(
                title: 'Id',
                subtitle: '10',
                //leading: const Icon(Icons.lightbulb),
              ),



            ])],
      ),
    );
  }
}