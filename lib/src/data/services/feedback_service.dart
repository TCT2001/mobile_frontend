import 'dart:convert';

import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class FeedbackService {
  static Future<CommonResp?> sendFeedback(String content) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.post(Uri.parse('$baseURL/test/feedback'),
        headers: authHeader(token!), body: jsonEncode(content));
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      return temp;
    } else {
      throw Exception('Failed');
    }
  }
}