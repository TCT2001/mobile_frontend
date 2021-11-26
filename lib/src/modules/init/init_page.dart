// ignore_for_file: unnecessary_this, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import '../../core/constants/colors.dart';
import 'init_controller.dart';


class InitPage extends GetView<InitController> {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: const [Colors.blueGrey, Colors.lightBlueAccent]),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    top: 120,
                    left: 125,
                    child: Image.asset(
                      'assets/images/Logo.png',
                      width: 200,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 160, left: 20),
                      child: Text(
                        "Hello we are Cyber Team",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 40),
                      child: Text("MAKIT - DESIGN YOUR OWN PROJECT"),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 60, right: 60),
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 300,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.LOGIN);
                            },
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.transparent,
                              primary: Color(0xff2d5f79),

                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(6),
                      //     gradient: LinearGradient(colors: const [
                      //       Colors.deepPurpleAccent,
                      //       Colors.lightBlueAccent,
                      //     ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 60, right: 60),
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 300,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.SIGNUP);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff2d5f79),
                            ),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(6),
                      //     gradient: LinearGradient(colors: const [
                      //       Colors.lightBlueAccent,
                      //       Colors.deepPurpleAccent,
                      //     ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RotatedBox(
                      quarterTurns: 0,
                      child: Text(
                        "CyberTeam Product",
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}

