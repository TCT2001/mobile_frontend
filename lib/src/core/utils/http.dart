import 'package:http/http.dart' as http;

var client = http.Client();
const baseURL = "https://tct-mobile-api.herokuapp.com/api";
// const baseURL = "http://localhost:8080/api";

Map<String, String> authHeader(String token) {
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
}

const nonAuthHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};
