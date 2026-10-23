import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _mobileNumberKey = 'login_mobile_number';
  static const String _districtNameKey = 'login_district_name';
  static const String _talukNameKey = 'login_taluk_name';
  static const String _districtCodeKey = 'login_district_code';
  static const String _talukCodeKey = 'login_taluk_code';

  static Future<void> saveLoginCredentials({
    required String mobileNumber,
    required String districtName,
    required String talukName,
    required String districtCode,
    required String talukCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_mobileNumberKey, mobileNumber);
    await prefs.setString(_districtNameKey, districtName);
    await prefs.setString(_talukNameKey, talukName);
    await prefs.setString(_districtCodeKey, districtCode);
    await prefs.setString(_talukCodeKey, talukCode);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<Map<String, String>> getLoginCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'mobileNumber': prefs.getString(_mobileNumberKey) ?? '',
      'districtName': prefs.getString(_districtNameKey) ?? '',
      'talukName': prefs.getString(_talukNameKey) ?? '',
      'districtCode': prefs.getString(_districtCodeKey) ?? '',
      'talukCode': prefs.getString(_talukCodeKey) ?? '',
    };
  }

  static Future<String> getMobileNumber() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_mobileNumberKey) ?? '';
  }

  static Future<String> getDistrictName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_districtNameKey) ?? '';
  }

  static Future<String> getTalukName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_talukNameKey) ?? '';
  }

  static Future<String> getDistrictCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_districtCodeKey) ?? '';
  }

  static Future<String> getTalukCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_talukCodeKey) ?? '';
  }

  static Future<void> clearLoginCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_mobileNumberKey);
    await prefs.remove(_districtNameKey);
    await prefs.remove(_talukNameKey);
    await prefs.remove(_districtCodeKey);
    await prefs.remove(_talukCodeKey);
  }
}
