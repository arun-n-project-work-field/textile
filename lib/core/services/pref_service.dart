import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static late SharedPreferences _pref;

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _pref.getString(key) ?? "";
  }

  static int getInt(String key) {
    return _pref.getInt(key) ?? 0;
  }

  static bool getBool(String key) {
    return _pref.getBool(key) ?? false;
  }

  static Future<void> setString(String key, String value) async {
    await _pref.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _pref.setBool(key, value);
  }

  static Future<void> remove(String key) async {
    await _pref.remove(key);
  }

  static Future<void> clear() async {
    await _pref.clear();
  }
}
