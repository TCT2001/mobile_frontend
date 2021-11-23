// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class HomePage extends GetView {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color(0xff88e8f2),
        appBar: AppBar(
          title: Text('Buyings'),
        ),
        body: Container(
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          // ),
          child: TextButton(
            child: Text("TEST"),
            onPressed: () async {
              var token =
                  await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
              print(token);
            },
          ),
        ));
  }
}
