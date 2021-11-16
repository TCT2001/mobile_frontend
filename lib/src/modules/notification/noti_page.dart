import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/navbar.dart';
import 'noti_controller.dart';

class NotiPage extends GetView<NotiController> {
  NotiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 20,
          title: const Text('Notification'),
        ),
        body: const SafeArea(
          child: Center(child: Text("This is Notification Page")),
        ),
        bottomNavigationBar: Narbar(selectedIndex: 3));
  }
}
