import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class ApiService {
  static const String genericUrl =
      'https://kgis.ksrsac.in/generic/api/genericselect';

  static const String otpUrl = 'https://kgis.ksrsac.in/OTPAPI/api/Verifymobile';

  // ==========================================================
  // APP VERSION
  // ==========================================================

  Future<Map<String, dynamic>> checkAppVersion() async {
    // Fetch installed app version dynamically from the platform.
    final packageInfo = await PackageInfo.fromPlatform();
    final installedVersion = packageInfo.version;

    debugPrint('INSTALLED APP VERSION: $installedVersion');

    final response = await http.post(
      Uri.parse(genericUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'applicantId': '1_CheckAppVersion',
        'parameter': 'P1\$|\$P2',
        'values': 'NammaKaimagga\$|\$$installedVersion',
      }),
    );

    debugPrint('VERSION STATUS CODE: ${response.statusCode}');
    debugPrint('VERSION RESPONSE BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Version API failed: ${response.statusCode}');
    }

    final dynamic decoded = jsonDecode(response.body);

    if (decoded is! List || decoded.isEmpty || decoded.first is! Map) {
      throw Exception('Invalid version API response');
    }

    final Map<String, dynamic> versionData = Map<String, dynamic>.from(
      decoded.first as Map,
    );

    final currentVersion = versionData['CurrentVersion']?.toString();

    if (currentVersion == null || currentVersion.trim().isEmpty) {
      throw Exception('CurrentVersion missing from version API response');
    }

    debugPrint('SERVER VERSION: $currentVersion');

    return versionData;
  }

  // ==========================================================
  // DISTRICTS
  // ==========================================================

  Future<List<Map<String, dynamic>>> getDistricts() async {
    final response = await http.post(
      Uri.parse(genericUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'applicantId': '1_GetAHAll',
        'parameter': 'P1\$|\$P2',
        'values': 'Rural\$|\$0',
      }),
    );

    debugPrint('DISTRICT STATUS CODE: ${response.statusCode}');

    debugPrint('DISTRICT RESPONSE BODY: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data is List) {
        return data
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }

      throw Exception('Invalid district API response');
    }

    throw Exception('District API failed: ${response.statusCode}');
  }

  // ==========================================================
  // TALUKS
  // ==========================================================

  Future<List<Map<String, dynamic>>> getTaluks(String districtCode) async {
    final requestBody = {
      'applicantId': '1_GetAHAll',
      'parameter': 'P1\$|\$P2',
      'values': 'Rural\$|\$$districtCode',
    };

    debugPrint('TALUK REQUEST: ${jsonEncode(requestBody)}');

    final response = await http.post(
      Uri.parse(genericUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    debugPrint('TALUK STATUS CODE: ${response.statusCode}');

    debugPrint('TALUK RESPONSE BODY: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data is List) {
        final result = <Map<String, dynamic>>[];

        for (final item in data) {
          if (item is Map) {
            final map = Map<String, dynamic>.from(item);

            if (map.containsKey('MSG')) {
              continue;
            }

            if (map['Code'] != null && map['Name'] != null) {
              result.add(map);
            }
          }
        }

        return result;
      }

      throw Exception('Invalid taluk API response');
    }

    throw Exception('Taluk API failed: ${response.statusCode}');
  }

  // ==========================================================
  // OTP
  // ==========================================================

  Future<Map<String, dynamic>> sendOtp(String mobile) async {
    final response = await http.get(Uri.parse('$otpUrl/$mobile'));

    debugPrint('OTP STATUS CODE: ${response.statusCode}');

    debugPrint('OTP RESPONSE BODY: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return data;
      }

      throw Exception('Invalid OTP API response');
    }

    throw Exception('OTP API failed: ${response.statusCode}');
  }
}
