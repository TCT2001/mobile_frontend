import 'package:http/http.dart' as http;
var client = http.Client();
const baseURL = "http://139.99.222.41:1111/api";
const token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0Y3QyMDAxIiwiaWF0IjoxNjM3NDAyNTA2LCJleHAiOjE2Mzc0ODg5MDZ9.GmvMIAzPVlJnbAiO6Jod3BD9SSRAKWk_2Nuik5AflGwkzBQM804f5pj33MEKHJxRKg7utrnK-zaE-xZULoZCZA";

const authHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $token'
};

const nonAuthHeader = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};
