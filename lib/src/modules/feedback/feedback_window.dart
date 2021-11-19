import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/modules/feedback/feedback_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

void displayFeedbackWindow() {
  late TextEditingController contentController = TextEditingController();
  String content = '';
  Get.bottomSheet(
      Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feedback',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  TextFormField(
                    controller: contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        hintText: 'Content',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Send feedback'),
                        icon: Icon(Icons.send),
                        onPressed: () {
                              content = contentController.text;
                              if(content != '') {
                                showSnackBar(
                                    "Feedback was sent!",
                                    "We are very lucky when having a user like you. Our team will try our best to develop the app. Thanks for your feedback!",
                                    Aquella);
                                contentController.clear();
                              }
                              else{
                                showSnackBar(
                                    "Nothing to send :(", "Enter your Feedback!", Red);
                              }
                            }
                    )
                  ],
                )
              ],
            ),
          )),
    );
}


showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
}