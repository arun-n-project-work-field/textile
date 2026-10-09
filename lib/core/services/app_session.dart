import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _mobileNumberKey = 'login_mobile_number';
  static const String _districtNameKey = 'login_district_name';
  static const String _districtCodeKey = 'login_district_code';
  static const String _talukNameKey = 'login_taluk_name';
  static const String _talukCodeKey = 'login_taluk_code';

  /// Save login/session details
  static Future<void> saveLoginCredentials({
    required String mobileNumber,
    required String districtName,
    required String districtCode,
    required String talukName,
    required String talukCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_mobileNumberKey, mobileNumber);
    await prefs.setString(_districtNameKey, districtName);
    await prefs.setString(_districtCodeKey, districtCode);
    await prefs.setString(_talukNameKey, talukName);
    await prefs.setString(_talukCodeKey, talukCode);
  }

  /// Check whether user is already logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Get saved login/session details
  static Future<Map<String, String>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'mobileNumber': prefs.getString(_mobileNumberKey) ?? '',
      'districtName': prefs.getString(_districtNameKey) ?? '',
      'districtCode': prefs.getString(_districtCodeKey) ?? '',
      'talukName': prefs.getString(_talukNameKey) ?? '',
      'talukCode': prefs.getString(_talukCodeKey) ?? '',
    };
  }

  /// Clear all saved login/session details
  static Future<void> clearLoginCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_mobileNumberKey);
    await prefs.remove(_districtNameKey);
    await prefs.remove(_districtCodeKey);
    await prefs.remove(_talukNameKey);
    await prefs.remove(_talukCodeKey);
  }

  /// Logout
  static Future<void> logout() async {
    await clearLoginCredentials();
  }
}