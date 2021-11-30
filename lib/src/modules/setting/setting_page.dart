import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/modules/init/init_page.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _a = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff88e8f2),
        body: Container(
            child: SettingsList(
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
                  leading: const Icon(Icons.notifications),
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
                    cleanLocalStorage();
                    Get.offAll(const InitPage(),
                        fullscreenDialog: true,
                        transition: Transition.cupertino,
                        duration: const Duration(seconds: 1));
                  },
                ),
              ],
            ),
          ],
        )));
  }
}
