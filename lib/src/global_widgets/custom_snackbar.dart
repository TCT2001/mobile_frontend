import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar(String? title, String? message, [int duration = 2]) {
  Get.snackbar(
    title!,
    message!,
    icon: const Icon(Icons.delete, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: duration),
    isDismissible: true,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
