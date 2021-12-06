import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/core/utils/percen_width_height.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_this
    this.controller.splashF();
    return Scaffold(
        backgroundColor: splashBg,
        body: SafeArea(
            child: SizedBox(
          height: 100.0.hp,
          width: 100.0.wp,
          child: Container(
            height: 50.0.hp,
            width: 100.0.hp,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/images/Best.gif'))),
          ),
        )));
  }
}
