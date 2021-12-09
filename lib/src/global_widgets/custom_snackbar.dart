import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';

void customSnackBar(String? title, String? message, {int duration = 2, Color backgroudColor = Colors.white, Color textColor = Colors.black, IconData? iconData, Color? iconColor}) {
  Get.snackbar(
    title!,
    message!,
    icon: Icon(iconData, color: iconColor),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroudColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText:textColor,
    duration: Duration(seconds: duration),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}