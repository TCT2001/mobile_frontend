// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/data/services/app_config_service.dart';

import 'search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  final String title = "Home";

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       AppConfigService.flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               AppConfigService.channel.id,
  //               AppConfigService.channel.name,
  //               AppConfigService.channel.description,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher',
  //             ),
  //           ));
  //     }
  //   });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Buyings'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: Search());
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(150),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("This is home page",
                          style: TextStyle(
                              color: Color(0xff88e8f2),
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                    ]),
              ))),
    );
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
