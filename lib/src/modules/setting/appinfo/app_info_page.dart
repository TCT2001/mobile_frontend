import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  @override
  _AppInfoPageState createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2d5f79),
        title: Text('App Info'),
      ),
      backgroundColor: const Color(0xff88e8f2),
      body: Container(
          child: SettingsList(sections: [
            SettingsSection(
                title: 'App Info',
                tiles: [
                  SettingsTile(
                    title: 'Name',
                    subtitle: 'Makit',
                    //leading: const Icon(Icons.info),
                  ),
                  SettingsTile(
                    title: 'Detail',
                    subtitle: 'toDoList used for projects management',
                    //leading: const Icon(Icons.lightbulb),
                  ),

                  SettingsTile(
                    title: 'Version',
                    subtitle: '1.0',
                    //leading: const Icon(Icons.lightbulb),

                  ),
                  SettingsTile(
                    title: 'Developer',
                    subtitle: 'Cyberteam',
                    //leading: const Icon(Icons.lightbulb),

                  ),

                  SettingsTile(
                    title: 'Properties',
                    subtitle: '100Mb',
                    //leading: const Icon(Icons.lightbulb),

                  ),
                ])],
          )),
    );
  }
}