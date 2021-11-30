import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/services/feedback_service.dart';

class FeedbackController extends GetxController {
  void onInit() {
    super.onInit();
  }

  Future<CommonResp?> sendFeedback(String content) async {
    var temp = await FeedbackService.sendFeedback(content);
    if (temp!.code == "SUCCESS") {
      //TODO
      //_listProject();
    }
    return temp;
  }

  @override
  void onClose() {
    super.onClose();
  }
}