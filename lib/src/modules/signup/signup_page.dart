import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/modules/signup/signup_controller.dart';
import 'package:mobile_app/src/widgets/button_New_User.dart';
import 'package:mobile_app/src/widgets/newEmail.dart';
import 'package:mobile_app/src/widgets/newName.dart';
import 'package:mobile_app/src/widgets/password.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);

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
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    NewName(),
                    NewEmail(),
                    PasswordInput(),
                    ButtonNewUser(),

                    // Padding(padding: EdgeInsets.only(top: 160, left: 20),
                    //   child: Text("Create your account",),
                    //
                    //
                    // ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 40),
                      child: Text("MAKIT - Design your own projects"),
                    ),
                  ],
                )
              ],
            )));
  }
}
//
