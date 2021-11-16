import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/modules/login/login_controller.dart';
import 'package:mobile_app/src/widgets/button_Login.dart';
import 'package:mobile_app/src/widgets/first.dart';
import 'package:mobile_app/src/widgets/inputEmail.dart';
import 'package:mobile_app/src/widgets/password.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                  Padding(
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
                  InputEmail(),
                  PasswordInput(),
                  Button(),
                  FirstTime(),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
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
