import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

Widget ButtonNewUser(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30, left: 20),
    child: Container(
      alignment: Alignment.bottomRight,
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.blue,
          blurRadius: 10.0, // has the effect of softening the shadow
          spreadRadius: 1.0, // has the effect of extending the shadow
          offset: Offset(
            5.0, // horizontal, move right 10
            5.0, // vertical, move down 10
          ),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.LOGIN);
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
