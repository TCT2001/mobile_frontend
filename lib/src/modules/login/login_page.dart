// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/button_no_data.dart';
import 'package:mobile_app/src/global_widgets/input_field.dart';
import 'package:mobile_app/src/modules/login/login_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent]),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 5),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InputField(context, 'Email'),
              InputField(context, 'Password', obscureText: true),
              CustomButtonNoData(context, Routes.NEO),
              FirstTime(),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 50,
                  right: 40,
                ),
                child: Text("MAKIT - Design your own projects"),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

Widget LoginButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30, left: 20),
    child: Container(
      alignment: Alignment.bottomRight,
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: FlatButton(
        onPressed: () {
          Get.toNamed(Routes.NEO);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'OK',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget FirstTime() {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 30),
    child: Container(
      alignment: Alignment.topRight,
      //color: Colors.red,
      height: 20,
      child: Row(
        children: <Widget>[
          const Text(
            'Your first time?',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Get.toNamed(Routes.SIGNUP);
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    ),
  );
}
