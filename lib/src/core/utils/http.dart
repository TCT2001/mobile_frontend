import 'package:http/http.dart' as http;
var client = http.Client();
const baseURL = "http://139.99.222.41:1111/api";
const token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0Y3QyMDAxIiwiaWF0IjoxNjM3MzE2OTg0LCJleHAiOjE2Mzc0MDMzODR9.5hhFX3rHU5nV36LNlzWsq3cwCj8QWtxwYEIXaIcmoluBl-2FcbgRMIyfwec_nvjC-mnbFJAzCnoJNSitlRenMQ";

const authHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $token'
};

const nonAuthHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};
