import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static const String _loggedInKey = 'logged_in';
  static const String _mobileKey = 'login_mobile';
  static const String _districtNameKey = 'login_district_name';
  static const String _districtCodeKey = 'login_district_code';
  static const String _talukNameKey = 'login_taluk_name';
  static const String _talukCodeKey = 'login_taluk_code';

  static Future<void> saveLogin({
    required String mobileNumber,
    required String districtName,
    required String districtCode,
    required String talukName,
    required String talukCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      _loggedInKey,
      true,
    );

    await prefs.setString(
      _mobileKey,
      mobileNumber,
    );

    await prefs.setString(
      _districtNameKey,
      districtName,
    );

    await prefs.setString(
      _districtCodeKey,
      districtCode,
    );

    await prefs.setString(
      _talukNameKey,
      talukName,
    );

    await prefs.setString(
      _talukCodeKey,
      talukCode,
    );
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<Map<String, String>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'mobileNumber': prefs.getString(_mobileKey) ?? '',
      'districtName': prefs.getString(_districtNameKey) ?? '',
      'districtCode': prefs.getString(_districtCodeKey) ?? '',
      'talukName': prefs.getString(_talukNameKey) ?? '',
      'talukCode': prefs.getString(_talukCodeKey) ?? '',
    };
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      _loggedInKey,
      false,
    );

    await prefs.remove(_mobileKey);
    await prefs.remove(_districtNameKey);
    await prefs.remove(_districtCodeKey);
    await prefs.remove(_talukNameKey);
    await prefs.remove(_talukCodeKey);
  }
}