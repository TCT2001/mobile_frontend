import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/navbar.dart';
import 'setting_controller.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:device_preview/device_preview.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is Setting Page"));

  }

}