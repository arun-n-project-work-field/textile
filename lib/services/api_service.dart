// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String genericUrl =
//       'https://kgis.ksrsac.in/generic/api/genericselect';

//   // Future<Map<String, dynamic>> checkAppVersion() async {
//   //   final response = await http.post(
//   //     Uri.parse(genericUrl),
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //     },
//   //     body: jsonEncode({
//   //       'applicantId': '1_CheckAppVersion',
//   //       'parameter': 'P1\$|\$P2',
//   //       'values': "NammaKaimagga\$+|\$v1.0",
//   //     }),
//   //   );

//   //   if (response.statusCode >= 200 &&
//   //       response.statusCode < 300) {
//   //     final decoded =
//   //         jsonDecode(response.body);

//   //     if (decoded is Map<String, dynamic>) {
//   //       return decoded;
//   //     }

//   //     throw Exception(
//   //       'Invalid version API response.',
//   //     );
//   //   }

//   //   throw Exception(
//   //     'Version API failed: ${response.statusCode}',
//   //   );
//   // }
//    // ==========================================================
//   // VERSION CHECK
//   // ==========================================================

//   Future<Map<String, dynamic>> checkAppVersion() async {
//     final response = await http.post(
//       Uri.parse(genericUrl),

//       headers: {
//         'Content-Type': 'application/json',
//       },

//       body: jsonEncode({
//         'applicantId':
//             '1_CheckAppVersion',

//         'parameter':
//             'P1\$|\$P2',

//         'values':
//             'NammaKaimagga\$|\$v1.0',
//       }),
//     );

//     if (response.statusCode >= 200 &&
//         response.statusCode < 300) {
//       final data =
//           jsonDecode(response.body);

//       if (data is Map<String, dynamic>) {
//         return data;
//       }

//       throw Exception(
//         'Invalid version response',
//       );
//     }

//     throw Exception(
//       'Version API failed: ${response.statusCode}',
//     );
//   }

//   // ==========================================================
//   // SEND OTP
//   // ==========================================================

//   Future<Map<String, dynamic>> sendOtp(
//     String mobile,
//   ) async {
//     final response = await http.get(
//       Uri.parse(
//         '\$otpUrl/$mobile',
//       ),
//     );

//     if (response.statusCode >= 200 &&
//         response.statusCode < 300) {
//       final data =
//           jsonDecode(response.body);

//       if (data is Map<String, dynamic>) {
//         return data;
//       }

//       throw Exception(
//         'Invalid OTP response',
//       );
//     }

//     throw Exception(
//       'OTP API failed: ${response.statusCode}',
//     );
//   }
// }

import 'dart:convert';

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

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return data;
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