// import 'package:shared_preferences/shared_preferences.dart';

// class AppSession {
//   static const String _loggedInKey = 'logged_in';
//   static const String _mobileKey = 'login_mobile';
//   static const String _districtNameKey = 'login_district_name';
//   static const String _districtCodeKey = 'login_district_code';
//   static const String _talukNameKey = 'login_taluk_name';
//   static const String _talukCodeKey = 'login_taluk_code';

//   static Future<void> saveLogin({
//     required String mobileNumber,
//     required String districtName,
//     required String districtCode,
//     required String talukName,
//     required String talukCode,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setBool(
//       _loggedInKey,
//       true,
//     );

//     await prefs.setString(
//       _mobileKey,
//       mobileNumber,
//     );

//     await prefs.setString(
//       _districtNameKey,
//       districtName,
//     );

//     await prefs.setString(
//       _districtCodeKey,
//       districtCode,
//     );

//     await prefs.setString(
//       _talukNameKey,
//       talukName,
//     );

//     await prefs.setString(
//       _talukCodeKey,
//       talukCode,
//     );
//   }

//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();

//     return prefs.getBool(_loggedInKey) ?? false;
//   }

//   static Future<Map<String, String>> getLoginData() async {
//     final prefs = await SharedPreferences.getInstance();

//     return {
//       'mobileNumber': prefs.getString(_mobileKey) ?? '',
//       'districtName': prefs.getString(_districtNameKey) ?? '',
//       'districtCode': prefs.getString(_districtCodeKey) ?? '',
//       'talukName': prefs.getString(_talukNameKey) ?? '',
//       'talukCode': prefs.getString(_talukCodeKey) ?? '',
//     };
//   }

//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setBool(
//       _loggedInKey,
//       false,
//     );

//     await prefs.remove(_mobileKey);
//     await prefs.remove(_districtNameKey);
//     await prefs.remove(_districtCodeKey);
//     await prefs.remove(_talukNameKey);
//     await prefs.remove(_talukCodeKey);
//   }
// }


import 'package:shared_preferences/shared_preferences.dart';

/// The single source of truth for authentication state.
/// Keep these keys consistent for login, splash/session restoration and logout.
class AppSession {
  AppSession._();

  static const String _isLoggedInKey = 'is_logged_in';
  static const String _mobileNumberKey = 'login_mobile_number';
  static const String _districtNameKey = 'login_district_name';
  static const String _districtCodeKey = 'login_district_code';
  static const String _talukNameKey = 'login_taluk_name';
  static const String _talukCodeKey = 'login_taluk_code';

  static Future<void> saveLoginCredentials({
    required String mobileNumber,
    required String districtName,
    required String districtCode,
    required String talukName,
    required String talukCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Write the profile first; mark the session active only after values are saved.
    await prefs.setString(_mobileNumberKey, mobileNumber.trim());
    await prefs.setString(_districtNameKey, districtName.trim());
    await prefs.setString(_districtCodeKey, districtCode.trim());
    await prefs.setString(_talukNameKey, talukName.trim());
    await prefs.setString(_talukCodeKey, talukCode.trim());
    await prefs.setBool(_isLoggedInKey, mobileNumber.trim().isNotEmpty);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final mobile = prefs.getString(_mobileNumberKey)?.trim() ?? '';
    return (prefs.getBool(_isLoggedInKey) ?? false) && mobile.isNotEmpty;
  }

  static Future<Map<String, String>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return <String, String>{
      'mobileNumber': prefs.getString(_mobileNumberKey) ?? '',
      'districtName': prefs.getString(_districtNameKey) ?? '',
      'districtCode': prefs.getString(_districtCodeKey) ?? '',
      'talukName': prefs.getString(_talukNameKey) ?? '',
      'talukCode': prefs.getString(_talukCodeKey) ?? '',
    };
  }

  /// Clear only authentication/session data. Do not clear device ID or local surveys.
  static Future<void> clearLoginCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_mobileNumberKey);
    await prefs.remove(_districtNameKey);
    await prefs.remove(_districtCodeKey);
    await prefs.remove(_talukNameKey);
    await prefs.remove(_talukCodeKey);
  }

  static Future<void> logout() => clearLoginCredentials();
}
