import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String?> getStringLocalStorge(String key) async {
  //TODO
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
