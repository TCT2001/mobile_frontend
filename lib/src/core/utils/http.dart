import 'package:http/http.dart' as http;
var client = http.Client();
const baseURL = "http://139.99.222.41:1111/api";
const token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0Y3QyMDAxIiwiaWF0IjoxNjM3Mjk2NjIyLCJleHAiOjE2MzczODMwMjJ9.gAsWbVQmn_25H2lmyqA9f4D4zCSzjWvGSfnFaUnvE_DcEjHlhFSYmEgoVO6p88Q7b_etw_icSndXrfPnz0tlDg";

const authHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $token'
};

const nonAuthHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};
