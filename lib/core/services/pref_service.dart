import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static late SharedPreferences _prefs;

  // ==========================================================
  // INITIALIZE
  // ==========================================================

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==========================================================
  // LOGIN STATUS
  // ==========================================================

  static const String _isLoggedInKey = 'is_logged_in';

  static bool get isLoggedIn {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_isLoggedInKey, value);
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  static Future<void> logout() async {
    await _prefs.setBool(_isLoggedInKey, false);
  }

  // ==========================================================
  // CLEAR ALL
  // ==========================================================

  static Future<void> clear() async {
    await _prefs.clear();
  }
}
