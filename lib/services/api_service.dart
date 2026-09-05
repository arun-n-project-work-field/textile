import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // ==========================================================
  // API URLs
  // ==========================================================

  static const String genericUrl =
      'https://kgis.ksrsac.in/generic/api/genericselect';

  static const String otpUrl =
      'https://kgis.ksrsac.in/OTPAPI/api/Verifymobile';

  // ==========================================================
  // VERSION CHECK API
  // ==========================================================

  Future<Map<String, dynamic>> checkAppVersion() async {
    final response = await http.post(
      Uri.parse(genericUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'applicantId': '1_CheckAppVersion',
        'parameter': 'P1\$|\$P2',
        'values': 'NammaKaimagga\$|\$v1.0',
      }),
    );

    debugPrint(
      'VERSION STATUS CODE: ${response.statusCode}',
    );

    debugPrint(
      'VERSION RESPONSE BODY: ${response.body}',
    );

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      debugPrint(
        'VERSION DECODED TYPE: ${data.runtimeType}',
      );

      debugPrint(
        'VERSION DECODED DATA: $data',
      );

      if (data is List && data.isNotEmpty) {
        final firstItem = data.first;

        if (firstItem is Map) {
          return Map<String, dynamic>.from(
            firstItem,
          );
        }
      }

      throw Exception(
        'Invalid version API response',
      );
    }

    throw Exception(
      'Version API failed: ${response.statusCode}',
    );
  }

  // ==========================================================
  // DISTRICT API
  // ==========================================================

  Future<List<Map<String, dynamic>>> getDistricts() async {
    final response = await http.post(
      Uri.parse(genericUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'applicantId': '1_GetAHAll',
        'parameter': 'P1\$|\$P2',
        'values': 'Rural\$|\$0',
      }),
    );

    debugPrint(
      'DISTRICT STATUS CODE: ${response.statusCode}',
    );

    debugPrint(
      'DISTRICT RESPONSE BODY: ${response.body}',
    );

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      debugPrint(
        'DISTRICT DECODED TYPE: ${data.runtimeType}',
      );

      if (data is List) {
        return data
            .whereType<Map>()
            .map(
              (item) => Map<String, dynamic>.from(
                item,
              ),
            )
            .toList();
      }

      throw Exception(
        'Invalid district API response',
      );
    }

    throw Exception(
      'District API failed: ${response.statusCode}',
    );
  }

  // ==========================================================
  // TALUK API
  // ==========================================================

  Future<List<Map<String, dynamic>>> getTaluks(
  String districtCode,
) async {
  final requestBody = {
    'applicantId': '1_GetAHAll',
    'parameter': 'P1\$|\$P2',
    'values': 'Rural\$|\$$districtCode',
  };

  debugPrint('========================================');
  debugPrint('TALUK API REQUEST');
  debugPrint('District Code: $districtCode');
  debugPrint('Request Body: ${jsonEncode(requestBody)}');
  debugPrint('========================================');

  final response = await http.post(
    Uri.parse(genericUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  debugPrint(
    'TALUK STATUS CODE: ${response.statusCode}',
  );

  debugPrint(
    'TALUK RESPONSE BODY: ${response.body}',
  );

  if (response.statusCode >= 200 &&
      response.statusCode < 300) {
    final data = jsonDecode(response.body);

    debugPrint(
      'TALUK DECODED TYPE: ${data.runtimeType}',
    );

    if (data is List) {
      final List<Map<String, dynamic>> result = [];

      for (final item in data) {
        if (item is Map) {
          final map =
              Map<String, dynamic>.from(item);

          // Ignore:
          // {"MSG":"no records found"}

          if (map.containsKey('MSG')) {
            debugPrint(
              'TALUK API MESSAGE: ${map['MSG']}',
            );

            continue;
          }

          if (map.containsKey('Code') &&
              map.containsKey('Name')) {
            result.add(map);
          }
        }
      }

      debugPrint(
        'TALUKS RETURNED: ${result.length}',
      );

      debugPrint(
        'TALUKS: $result',
      );

      return result;
    }

    throw Exception(
      'Invalid taluk API response',
    );
  }

  throw Exception(
    'Taluk API failed: ${response.statusCode}',
  );
}

  // ==========================================================
  // SEND OTP API
  // ==========================================================

  Future<Map<String, dynamic>> sendOtp(
    String mobile,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$otpUrl/$mobile',
      ),
    );

    debugPrint(
      'OTP STATUS CODE: ${response.statusCode}',
    );

    debugPrint(
      'OTP RESPONSE BODY: ${response.body}',
    );

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return data;
      }

      throw Exception(
        'Invalid OTP API response',
      );
    }

    throw Exception(
      'OTP API failed: ${response.statusCode}',
    );
  }
}