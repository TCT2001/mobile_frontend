import 'package:http/http.dart' as http;

var client = http.Client();
const baseURL = "http://139.99.222.41:1111/api";

Map<String, String> authHeader(String token) {
  token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0Y3RAMjAwMS5jb20iLCJpYXQiOjE2Mzc0NjMyNjUsImV4cCI6MTYzNzU0OTY2NX0.rAxRUeZJs6Sqq4uHABFdLF0dtE8yAlSJw9S5N0JzxS7qltSgedM5tAdMI4A9RtZLClUYLgj5eWNfQXd25IwD9g";
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
}

const nonAuthHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};
