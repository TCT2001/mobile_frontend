import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String?> getStringLocalStorge(String key) async {
  //TODO
  if (key == LocalStorageKey.TOKEN.toString()) {
    return "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0Y3RAMjAwMS5jb20iLCJpYXQiOjE2Mzc0NjQyMTEsImV4cCI6MTYzNzU1MDYxMX0.HUezlmTqctJwqrMLljNx2FufZKPGg5O1jLPytE39m4drwduSqX-Pw9bM5tUmnqz2-K-T3S5NtXr5RJT3arz0tA";
  }
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(key);
}

void setStringLocalStorge(String key, String value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setString(key, value);
}

Future<int?> getIntLocalStorge(String key) async {
  final SharedPreferences prefs = await _prefs;
  return prefs.getInt(key);
}

void setIntLocalStorge(String key, int value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setInt(key, value);
}
