import 'package:http/http.dart' as http;

var client = http.Client();
<<<<<<< HEAD
// const baseURL = "http://139.99.222.41:1111/api";
const baseURL = "https://tct-mobile-api.herokuapp.com/api";
=======
const baseURL = "https://tct-mobile-api.herokuapp.com/api";
// const baseURL = "http://localhost:8080/api";
>>>>>>> origin/ngoc

Map<String, String> authHeader(String token) {
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
}

const nonAuthHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};
