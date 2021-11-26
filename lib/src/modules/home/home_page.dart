// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

import 'search.dart';

class HomePage extends GetView {
  const HomePage({Key? key}) : super(key: key);

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
          // child: TextButton(
          //   child: Text("TEST"),
          //   onPressed: () async {
          //     var token =
          //         await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
          //     print(token);
          //   },
          // ),
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
              )
          )),
    )
    ;
  }
}

