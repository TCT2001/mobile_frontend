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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: const Color(0xff88e8f2),
      body: Container(
          child: SettingsList(sections: [
            SettingsSection(
                title: 'Account',
                tiles: [
                  SettingsTile(
                    title: 'Email',
                    subtitle: '0976999999',
                    //leading: const Icon(Icons.info),
                  ),
                  SettingsTile(
                    title: 'Id',
                    subtitle: '10',
                    //leading: const Icon(Icons.lightbulb),
                  ),

                  SettingsTile(
                    title: 'Name',
                    subtitle: 'Vu Minh Tuyen',
                    //leading: const Icon(Icons.lightbulb),

                  ),
                  // SettingsTile(
                  //   title: 'Developer',
                  //   subtitle: 'Cyberteam',
                  //   //leading: const Icon(Icons.lightbulb),
                  //
                  // ),
                  //
                  // SettingsTile(
                  //   title: 'Properties',
                  //   subtitle: '100Mb',
                  //   //leading: const Icon(Icons.lightbulb),
                  //
                  // ),
                ])],
          )),
    );
  }
}