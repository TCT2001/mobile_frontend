import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/button_new_user.dart';
import 'package:mobile_app/src/global_widgets/input_field.dart';
import 'package:mobile_app/src/modules/signup/signup_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);

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

                    InputField(context, 'Name'),
                    InputField(context, 'Email'),
                    InputField(context, 'Password', obscureText: true),
                    ButtonNewUser(context),

                    // Padding(padding: EdgeInsets.only(top: 160, left: 20),
                    //   child: Text("Create your account",),
                    //
                    //
                    // ),
                    const SizedBox(
                      height: 10,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 50, right: 40),
                      child: Text("MAKIT - Design your own projects"),
                    ),
                  ],
                )
              ],
            )));
  }
}