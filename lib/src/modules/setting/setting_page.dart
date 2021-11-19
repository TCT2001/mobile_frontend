import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/widgets.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _a = true;

  @override
  Widget build(BuildContext context) {
    return Center(child: SettingsList(
      sections: [
        SettingsSection(
          title: 'Section',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: const Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              title: 'Allow Notifications',
              leading: Icon(Icons.notifications),
              switchValue: _a,
              onToggle: (bool value) {
                setState(() {
                  _a = value;
                });
              },
            ),
            SettingsTile(
              title: 'App Info',
              leading: const Icon(Icons.info),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Change Password',
              leading: const Icon(Icons.lock),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Logout',
              leading: const Icon(Icons.logout),
              onPressed: (BuildContext context) {
                Get.offAllNamed(Routes.INIT);
              },
            ),
          ],
        ),
      ],
    ));
  }

}