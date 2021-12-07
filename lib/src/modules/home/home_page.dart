// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/data/models/task.dart';
import 'package:mobile_app/src/data/services/app_config_service.dart';
import 'package:mobile_app/src/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  final String title = "Home";

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _counter = 0;
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        AppConfigService.flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                AppConfigService.channel.id,
                AppConfigService.channel.name,
                AppConfigService.channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    homeController.updateT();
    List<Task> tasks = homeController.recentTask;
    return Scaffold(
      backgroundColor: Bg,
      appBar: AppBar(
        backgroundColor: Color(0xff2d5f79),
        title: Text('Home'),
      ),
      body: GetBuilder<HomeController>(
        builder: (_dx) => ListView.builder(
            itemCount: _dx.recentTask.length,
            itemBuilder: (context, index) {
              return buildCard(_dx.recentTask[index]);
            }),
      ),
    );
  }

  Widget buildCard(Task task) {
    if (task.id == -1) {
      return SizedBox.shrink();
    }
    String deadline = task.deadline ?? "no set";
    var subheading = task.name;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          Center(child: Text("Recent Tasks")),
          Container(
              margin: EdgeInsets.only(right: 20, top: 5, bottom: 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: HexColor("#4fddd6"),
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(task.taskState!,
                          style: TextStyle(
                              color: HexColor("#352b2e"),
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: HexColor("#e8688e"),
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(task.priority!,
                          style: TextStyle(
                              color: HexColor("#352b2e"),
                              fontWeight: FontWeight.bold)),
                    ),
                  ])),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              "${task.content}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("\u{1F511}    $subheading"),
          ),
          Container(
              height: 15,
              margin: EdgeInsets.only(right: 20, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("Deadline: $deadline")]))
        ]));
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    // AppConfigService.flutterLocalNotificationsPlugin.show(
    //     0,
    //     "Testing $_counter",
    //     "How you doin ?",
    //     NotificationDetails(
    //         android: AndroidNotificationDetails(
    //             AppConfigService.channel.id,
    //             AppConfigService.channel.name,
    //             AppConfigService.channel.description,
    //             importance: Importance.high,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher')));
  }
}
