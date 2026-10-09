// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_compress/image_compress.dart';
// import 'package:path/path.dart' as path;

// import '../../core/database/database_helper.dart';

// class SyncDataController extends GetxController {
//   final DatabaseHelper database = DatabaseHelper.instance;

//   final Dio _dio = Dio(
//     BaseOptions(
//       connectTimeout: const Duration(seconds: 60),
//       sendTimeout: const Duration(seconds: 180),
//       receiveTimeout: const Duration(seconds: 180),
//     ),
//   );

//   static const String syncUrl =
//       'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

//   static const String versionUrl =
//       'https://kgis.ksrsac.in/api/app/version';

//   static const String applicantId =
//       '1_Insert_Handloom_Data_Trans';

//   static const String parameter =
//       'P1\$|\$P2\$|\$P3\$|\$P4\$|\$P5\$|\$P6\$|\$P7\$|\$P8\$|\$P9\$|\$P10\$|\$P11\$|\$P12\$|\$P13\$|\$P14\$|\$P15\$|\$P16\$|\$P17\$|\$P100';

//   final RxList<Map<String, dynamic>> pendingData =
//       <Map<String, dynamic>>[].obs;

//   final RxBool isLoading = false.obs;
//   final RxBool isSyncing = false.obs;

//   final RxInt totalCount = 0.obs;
//   final RxInt successCount = 0.obs;
//   final RxInt failedCount = 0.obs;

//   final RxString currentUniqueId = ''.obs;
//   final RxString statusMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadPendingData();
//   }

//   // ---------------------------------------------------------------------------
//   // LOAD PENDING DATA
//   // ---------------------------------------------------------------------------

//   Future<void> loadPendingData() async {
//     try {
//       isLoading.value = true;

//       final data = await database.getPendingSurveys();

//       pendingData.assignAll(
//         data.map((e) => Map<String, dynamic>.from(e)).toList(),
//       );

//       totalCount.value = pendingData.length;
//     } catch (e) {
//       debugPrint('LOAD PENDING DATA ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to load pending data.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // SYNC ALL DATA
//   // ---------------------------------------------------------------------------

//   Future<void> syncAllData() async {
//     if (isSyncing.value) {
//       return;
//     }

//     if (pendingData.isEmpty) {
//       Get.snackbar(
//         'Sync Data',
//         'No pending data available for synchronization.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     isSyncing.value = true;

//     successCount.value = 0;
//     failedCount.value = 0;

//     statusMessage.value = 'Starting synchronization...';

//     try {
//       final syncedVersion = await _getLatestAppVersion();

//       debugPrint('SYNC VERSION: $syncedVersion');

//       for (final survey in List<Map<String, dynamic>>.from(pendingData)) {
//         final uniqueId = survey['p1']?.toString() ?? '';

//         currentUniqueId.value = uniqueId;

//         statusMessage.value =
//             'Syncing ${successCount.value + failedCount.value + 1}'
//             ' of ${pendingData.length}';

//         final success = await _syncSingleSurvey(
//           survey,
//           syncedVersion,
//         );

//         if (success) {
//           successCount.value++;
//         } else {
//           failedCount.value++;
//         }
//       }

//       await loadPendingData();

//       statusMessage.value = 'Synchronization completed.';

//       if (failedCount.value == 0) {
//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} record(s) synchronized successfully.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} succeeded, '
//           '${failedCount.value} failed.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint('SYNC ALL ERROR: $e');

//       statusMessage.value = 'Synchronization failed.';

//       Get.snackbar(
//         'Sync Error',
//         'Unable to complete synchronization.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       currentUniqueId.value = '';
//       isSyncing.value = false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // SYNC SINGLE RECORD
//   // ---------------------------------------------------------------------------

//   Future<bool> _syncSingleSurvey(
//     Map<String, dynamic> survey,
//     String syncedVersion,
//   ) async {
//     try {
//       final p1 = _value(survey, 'p1');
//       final p2 = _value(survey, 'p2');
//       final p3 = _value(survey, 'p3');
//       final p4 = _value(survey, 'p4');
//       final p5 = _value(survey, 'p5');
//       final p6 = _value(survey, 'p6');
//       final p7 = _value(survey, 'p7');

//       final p8 = _value(survey, 'p8');
//       final p9 = _value(survey, 'p9');

//       final p10 = _value(survey, 'p10');
//       final p11 = _value(survey, 'p11');

//       final p12 = _value(survey, 'p12');
//       final p13 = _value(survey, 'p13');
//       final p14 = _value(survey, 'p14');
//       final p15 = _value(survey, 'p15');

//       // P16 is sent as the current application version during sync.
//       final p16 = syncedVersion;

//       final p17 = _value(survey, 'p17');
//       final p100 = _value(survey, 'p100');

//       final values = [
//         p1,
//         p2,
//         p3,
//         p4,
//         p5,
//         p6,
//         p7,
//         p8,
//         p9,
//         p10,
//         p11,
//         p12,
//         p13,
//         p14,
//         p15,
//         p16,
//         p17,
//         p100,
//       ].join('\$|\$');

//       debugPrint('--------------------------------------------------');
//       debugPrint('SYNC UNIQUE ID: $p1');
//       debugPrint('SYNC APPLICANT ID: $applicantId');
//       debugPrint('SYNC PARAMETERS: $parameter');
//       debugPrint('SYNC VALUES: $values');

//       final formData = FormData();

//       formData.fields.add(
//         MapEntry('applicantId', applicantId),
//       );

//       formData.fields.add(
//         MapEntry('parameter', parameter),
//       );

//       formData.fields.add(
//         MapEntry('values', values),
//       );

//       // -----------------------------------------------------------------------
//       // PHOTO 1
//       // -----------------------------------------------------------------------

//       final photo1Path = _validPath(p8);

//       if (photo1Path != null) {
//         final photo1File = await _preparePngFile(
//           photo1Path,
//           p1,
//           'photo1',
//         );

//         if (photo1File != null) {
//           formData.files.add(
//             MapEntry(
//               'photo1',
//               await MultipartFile.fromFile(
//                 photo1File.path,
//                 filename: '${p1}_photo1.png',
//               ),
//             ),
//           );
//         }
//       }

//       // -----------------------------------------------------------------------
//       // PHOTO 2
//       // -----------------------------------------------------------------------

//       final photo2Path = _validPath(p9);

//       if (photo2Path != null) {
//         final photo2File = await _preparePngFile(
//           photo2Path,
//           p1,
//           'photo2',
//         );

//         if (photo2File != null) {
//           formData.files.add(
//             MapEntry(
//               'photo2',
//               await MultipartFile.fromFile(
//                 photo2File.path,
//                 filename: '${p1}_photo2.png',
//               ),
//             ),
//           );
//         }
//       }

//       final response = await _dio.post(
//         syncUrl,
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data',
//           responseType: ResponseType.json,
//         ),
//       );

//       debugPrint('SYNC HTTP STATUS: ${response.statusCode}');
//       debugPrint('SYNC RESPONSE: ${response.data}');

//       if (_isSuccessfulResponse(response)) {
//         await database.updateSyncedVersion(
//           p1,
//           syncedVersion,
//         );

//         await database.updateSyncStatus(
//           p1,
//           'Synced',
//         );

//         return true;
//       }

//       await database.updateSyncStatus(
//         p1,
//         'Pending',
//       );

//       return false;
//     } catch (e) {
//       debugPrint(
//         'SYNC ERROR [$p1]: $e',
//       );

//       await database.updateSyncStatus(
//         p1,
//         'Pending',
//       );

//       return false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // API SUCCESS CHECK
//   // ---------------------------------------------------------------------------

//   bool _isSuccessfulResponse(Response response) {
//     if (response.statusCode != 200 &&
//         response.statusCode != 201) {
//       return false;
//     }

//     final data = response.data;

//     if (data is Map<String, dynamic>) {
//       if (data['success'] == true) {
//         return true;
//       }

//       final statusCode = data['statusCode'];

//       if (statusCode == 200 ||
//           statusCode == '200' ||
//           statusCode == 201 ||
//           statusCode == '201') {
//         return true;
//       }

//       final status = data['status']?.toString().toLowerCase();

//       if (status == 'success' ||
//           status == 'true') {
//         return true;
//       }
//     }

//     // Some legacy APIs return HTTP 200 with a non-standard response.
//     if (response.statusCode == 200) {
//       if (data is String) {
//         final text = data.toLowerCase();

//         if (text.contains('success') ||
//             text.contains('inserted') ||
//             text.contains('saved')) {
//           return true;
//         }
//       }
//     }

//     return false;
//   }

//   // ---------------------------------------------------------------------------
//   // GET CURRENT APP VERSION
//   // ---------------------------------------------------------------------------

//   Future<String> _getLatestAppVersion() async {
//     try {
//       final response = await _dio.get(
//         versionUrl,
//         options: Options(
//           responseType: ResponseType.json,
//         ),
//       );

//       debugPrint(
//         'VERSION API RESPONSE: ${response.data}',
//       );

//       final data = response.data;

//       if (data is Map<String, dynamic>) {
//         final nestedData = data['data'];

//         if (nestedData is Map<String, dynamic>) {
//           final version =
//               nestedData['appVersion']?.toString();

//           if (version != null && version.isNotEmpty) {
//             return version;
//           }
//         }

//         final version =
//             data['appVersion']?.toString();

//         if (version != null && version.isNotEmpty) {
//           return version;
//         }
//       }
//     } catch (e) {
//       debugPrint(
//         'GET VERSION FOR SYNC ERROR: $e',
//       );
//     }

//     // If version API is unavailable, keep P16 empty rather than
//     // inventing a version.
//     return '';
//   }

//   // ---------------------------------------------------------------------------
//   // PNG PREPARATION
//   // ---------------------------------------------------------------------------

//   Future<File?> _preparePngFile(
//     String sourcePath,
//     String uniqueId,
//     String photoName,
//   ) async {
//     try {
//       final sourceFile = File(sourcePath);

//       if (!await sourceFile.exists()) {
//         debugPrint(
//           '$photoName does not exist: $sourcePath',
//         );
//         return null;
//       }

//       final outputDirectory =
//           Directory('${sourceFile.parent.path}/sync_png');

//       if (!await outputDirectory.exists()) {
//         await outputDirectory.create(
//           recursive: true,
//         );
//       }

//       final outputPath = path.join(
//         outputDirectory.path,
//         '${uniqueId}_$photoName.png',
//       );

//       final result =
//           await FlutterImageCompress.compressAndGetFile(
//         sourceFile.path,
//         outputPath,
//         format: CompressFormat.png,
//       );

//       if (result == null) {
//         debugPrint(
//           '$photoName PNG conversion failed.',
//         );
//         return null;
//       }

//       return File(result.path);
//     } catch (e) {
//       debugPrint(
//         '$photoName PNG preparation error: $e',
//       );
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // HELPERS
//   // ---------------------------------------------------------------------------

//   String _value(
//     Map<String, dynamic> data,
//     String key,
//   ) {
//     return data[key]?.toString() ?? '';
//   }

//   String? _validPath(String value) {
//     if (value.trim().isEmpty) {
//       return null;
//     }

//     return value;
//   }

//   // ---------------------------------------------------------------------------
//   // REFRESH
//   // ---------------------------------------------------------------------------

//   Future<void> refresh() async {
//     if (isSyncing.value) {
//       return;
//     }

//     await loadPendingData();
//   }
// }



// import 'dart:io';

// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart' as path;

// import '../../database/database_helper.dart';

// class SyncDataController extends GetxController {
//   final DatabaseHelper database = DatabaseHelper.instance;

//   final dio.Dio _dio = dio.Dio(
//     dio.BaseOptions(
//       connectTimeout: const Duration(seconds: 60),
//       sendTimeout: const Duration(seconds: 180),
//       receiveTimeout: const Duration(seconds: 180),
//     ),
//   );

//   // ---------------------------------------------------------------------------
//   // API
//   // ---------------------------------------------------------------------------

//   static const String syncUrl =
//       'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

//   static const String versionUrl =
//       'https://kgis.ksrsac.in/api/app/version';

//   static const String applicantId =
//       '1_Insert_Handloom_Data_Trans';

//   static const String parameter =
//       r'P1$|$P2$|$P3$|$P4$|$P5$|$P6$|$P7$|$P8$|$P9$|$P10$|$P11$|$P12$|$P13$|$P14$|$P15$|$P16$|$P17$|$P100';

//   // ---------------------------------------------------------------------------
//   // OBSERVABLES
//   // ---------------------------------------------------------------------------

//   final RxList<Map<String, dynamic>> pendingData =
//       <Map<String, dynamic>>[].obs;

//   final RxBool isLoading = false.obs;
//   final RxBool isSyncing = false.obs;

//   final RxInt totalCount = 0.obs;
//   final RxInt successCount = 0.obs;
//   final RxInt failedCount = 0.obs;

//   final RxString currentUniqueId = ''.obs;

//   final RxString statusMessage =
//       'Loading pending data...'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadPendingData();
//   }

//   // ---------------------------------------------------------------------------
//   // LOAD PENDING DATA
//   // ---------------------------------------------------------------------------

//   Future<void> loadPendingData() async {
//     if (isSyncing.value) {
//       return;
//     }

//     try {
//       isLoading.value = true;

//       final data =
//           await database.getPendingSurveys();

//       pendingData.assignAll(
//         data
//             .map(
//               (item) =>
//                   Map<String, dynamic>.from(item),
//             )
//             .toList(),
//       );

//       totalCount.value =
//           pendingData.length;

//       statusMessage.value =
//           pendingData.isEmpty
//               ? 'No pending data available.'
//               : '${pendingData.length} pending record(s) available.';

//       debugPrint(
//         'PENDING RECORD COUNT: ${pendingData.length}',
//       );
//     } catch (e) {
//       debugPrint(
//         'LOAD PENDING DATA ERROR: $e',
//       );

//       statusMessage.value =
//           'Unable to load pending data.';

//       Get.snackbar(
//         'Error',
//         'Unable to load pending data.',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // START SYNC
//   // ---------------------------------------------------------------------------

//   Future<void> syncAllData() async {
//     if (isSyncing.value) {
//       return;
//     }

//     await loadPendingData();

//     if (pendingData.isEmpty) {
//       Get.snackbar(
//         'Sync Data',
//         'No pending data available for synchronization.',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     isSyncing.value = true;

//     successCount.value = 0;
//     failedCount.value = 0;

//     statusMessage.value =
//         'Getting application version...';

//     try {
//       final syncedVersion =
//           await _getLatestAppVersion();

//       debugPrint(
//         'SYNC APP VERSION: $syncedVersion',
//       );

//       final records =
//           List<Map<String, dynamic>>.from(
//         pendingData,
//       );

//       for (int i = 0; i < records.length; i++) {
//         final survey = records[i];

//         final uniqueId =
//             _value(survey, 'p1');

//         currentUniqueId.value =
//             uniqueId;

//         statusMessage.value =
//             'Syncing ${i + 1} of ${records.length}';

//         debugPrint(
//           'SYNCING RECORD ${i + 1}/${records.length}: $uniqueId',
//         );

//         final success =
//             await _syncSingleSurvey(
//           survey,
//           syncedVersion,
//         );

//         if (success) {
//           successCount.value++;
//         } else {
//           failedCount.value++;
//         }
//       }

//       await loadPendingData();

//       currentUniqueId.value = '';

//       if (failedCount.value == 0) {
//         statusMessage.value =
//             'Synchronization completed successfully.';

//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} record(s) synchronized successfully.',
//           snackPosition:
//               SnackPosition.BOTTOM,
//           duration:
//               const Duration(seconds: 4),
//         );
//       } else {
//         statusMessage.value =
//             'Synchronization completed with some failures.';

//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} succeeded, '
//               '${failedCount.value} failed.',
//           snackPosition:
//               SnackPosition.BOTTOM,
//           duration:
//               const Duration(seconds: 5),
//         );
//       }
//     } catch (e) {
//       debugPrint(
//         'SYNC ALL ERROR: $e',
//       );

//       statusMessage.value =
//           'Synchronization failed.';

//       Get.snackbar(
//         'Sync Error',
//         'Unable to complete synchronization.',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//     } finally {
//       currentUniqueId.value = '';
//       isSyncing.value = false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // SYNC SINGLE SURVEY
//   // ---------------------------------------------------------------------------

//   Future<bool> _syncSingleSurvey(
//     Map<String, dynamic> survey,
//     String syncedVersion,
//   ) async {
//     final p1 =
//         _value(survey, 'p1');

//     try {
//       final p2 =
//           _value(survey, 'p2');

//       final p3 =
//           _value(survey, 'p3');

//       final p4 =
//           _value(survey, 'p4');

//       final p5 =
//           _value(survey, 'p5');

//       final p6 =
//           _value(survey, 'p6');

//       final p7 =
//           _value(survey, 'p7');

//       final p8 =
//           _value(survey, 'p8');

//       final p9 =
//           _value(survey, 'p9');

//       final p10 =
//           _value(survey, 'p10');

//       final p11 =
//           _value(survey, 'p11');

//       final p12 =
//           _value(survey, 'p12');

//       final p13 =
//           _value(survey, 'p13');

//       final p14 =
//           _value(survey, 'p14');

//       final p15 =
//           _value(survey, 'p15');

//       // P16 comes from the server version API.
//       final p16 =
//           syncedVersion;

//       final p17 =
//           _value(survey, 'p17');

//       final p100 =
//           _value(survey, 'p100');

//       // P101 is intentionally not included.

//       final values = [
//         p1,
//         p2,
//         p3,
//         p4,
//         p5,
//         p6,
//         p7,
//         p8,
//         p9,
//         p10,
//         p11,
//         p12,
//         p13,
//         p14,
//         p15,
//         p16,
//         p17,
//         p100,
//       ].join(r'$|$');

//       debugPrint(
//         '--------------------------------------------------',
//       );

//       debugPrint(
//         'SYNC UNIQUE ID: $p1',
//       );

//       debugPrint(
//         'SYNC APPLICANT ID: $applicantId',
//       );

//       debugPrint(
//         'SYNC PARAMETERS: $parameter',
//       );

//       debugPrint(
//         'SYNC VALUES: $values',
//       );

//       // -----------------------------------------------------------------------
//       // FORM DATA
//       // -----------------------------------------------------------------------

//       final formData =
//           dio.FormData.fromMap(
//         {
//           'applicantId':
//               applicantId,
//           'parameter':
//               parameter,
//           'values':
//               values,
//         },
//       );

//       // -----------------------------------------------------------------------
//       // PHOTO 1
//       // -----------------------------------------------------------------------

//       final photo1Path =
//           _validPath(p8);

//       if (photo1Path != null) {
//         final photo1File =
//             await _preparePngFile(
//           photo1Path,
//           p1,
//           'photo1',
//         );

//         if (photo1File != null) {
//           formData.files.add(
//             MapEntry(
//               'photo1',
//               await dio.MultipartFile.fromFile(
//                 photo1File.path,
//                 filename:
//                     '${p1}_photo1.png',
//               ),
//             ),
//           );

//           debugPrint(
//             'PHOTO 1 ATTACHED',
//           );
//         }
//       }

//       // -----------------------------------------------------------------------
//       // PHOTO 2
//       // -----------------------------------------------------------------------

//       final photo2Path =
//           _validPath(p9);

//       if (photo2Path != null) {
//         final photo2File =
//             await _preparePngFile(
//           photo2Path,
//           p1,
//           'photo2',
//         );

//         if (photo2File != null) {
//           formData.files.add(
//             MapEntry(
//               'photo2',
//               await dio.MultipartFile.fromFile(
//                 photo2File.path,
//                 filename:
//                     '${p1}_photo2.png',
//               ),
//             ),
//           );

//           debugPrint(
//             'PHOTO 2 ATTACHED',
//           );
//         }
//       }

//       // -----------------------------------------------------------------------
//       // POST
//       // -----------------------------------------------------------------------

//       final dio.Response response =
//           await _dio.post(
//         syncUrl,
//         data: formData,
//         options: dio.Options(
//           contentType:
//               'multipart/form-data',
//           responseType:
//               dio.ResponseType.json,
//         ),
//       );

//       debugPrint(
//         'SYNC HTTP STATUS: ${response.statusCode}',
//       );

//       debugPrint(
//         'SYNC RESPONSE: ${response.data}',
//       );

//       // -----------------------------------------------------------------------
//       // SUCCESS
//       // -----------------------------------------------------------------------

//       if (_isSuccessfulResponse(
//         response,
//       )) {
//         await database.updateSyncedVersion(
//           p1,
//           syncedVersion,
//         );

//         await database.updateSyncStatus(
//           p1,
//           'Synced',
//         );

//         debugPrint(
//           'SYNC SUCCESS: $p1',
//         );

//         return true;
//       }

//       // -----------------------------------------------------------------------
//       // FAILURE
//       // -----------------------------------------------------------------------

//       await database.updateSyncStatus(
//         p1,
//         'Pending',
//       );

//       debugPrint(
//         'SYNC FAILED: $p1',
//       );

//       return false;
//     } on dio.DioException catch (e) {
//       debugPrint(
//         'DIO SYNC ERROR [$p1]',
//       );

//       debugPrint(
//         'TYPE: ${e.type}',
//       );

//       debugPrint(
//         'MESSAGE: ${e.message}',
//       );

//       debugPrint(
//         'STATUS: ${e.response?.statusCode}',
//       );

//       debugPrint(
//         'RESPONSE: ${e.response?.data}',
//       );

//       await database.updateSyncStatus(
//         p1,
//         'Pending',
//       );

//       return false;
//     } catch (e) {
//       debugPrint(
//         'SYNC ERROR [$p1]: $e',
//       );

//       await database.updateSyncStatus(
//         p1,
//         'Pending',
//       );

//       return false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // SUCCESS RESPONSE CHECK
//   // ---------------------------------------------------------------------------

//   bool _isSuccessfulResponse(
//     dio.Response response,
//   ) {
//     final statusCode =
//         response.statusCode;

//     if (statusCode != 200 &&
//         statusCode != 201) {
//       return false;
//     }

//     final data =
//         response.data;

//     if (data is Map) {
//       final success =
//           data['success'];

//       if (success == true ||
//           success
//                   ?.toString()
//                   .toLowerCase() ==
//               'true') {
//         return true;
//       }

//       final statusCodeValue =
//           data['statusCode'];

//       if (statusCodeValue == 200 ||
//           statusCodeValue == '200' ||
//           statusCodeValue == 201 ||
//           statusCodeValue == '201') {
//         return true;
//       }

//       final status =
//           data['status']
//               ?.toString()
//               .toLowerCase();

//       if (status == 'success' ||
//           status == 'true') {
//         return true;
//       }

//       final message =
//           data['message']
//               ?.toString()
//               .toLowerCase();

//       if (message != null &&
//           (message.contains('success') ||
//               message.contains('inserted') ||
//               message.contains('saved'))) {
//         return true;
//       }
//     }

//     if (data is String) {
//       final text =
//           data.toLowerCase();

//       if (text.contains('success') ||
//           text.contains('inserted') ||
//           text.contains('saved')) {
//         return true;
//       }
//     }

//     return false;
//   }

//   // ---------------------------------------------------------------------------
//   // GET SERVER APP VERSION
//   // ---------------------------------------------------------------------------

//   Future<String>
//       _getLatestAppVersion() async {
//     try {
//       final dio.Response response =
//           await _dio.get(
//         versionUrl,
//         options: dio.Options(
//           responseType:
//               dio.ResponseType.json,
//         ),
//       );

//       debugPrint(
//         'VERSION API STATUS: ${response.statusCode}',
//       );

//       debugPrint(
//         'VERSION API RESPONSE: ${response.data}',
//       );

//       final data =
//           response.data;

//       if (data is Map) {
//         final nestedData =
//             data['data'];

//         if (nestedData is Map) {
//           final version =
//               nestedData['appVersion']
//                   ?.toString();

//           if (version != null &&
//               version.isNotEmpty) {
//             return version;
//           }
//         }

//         final version =
//             data['appVersion']
//                 ?.toString();

//         if (version != null &&
//             version.isNotEmpty) {
//           return version;
//         }
//       }
//     } on dio.DioException catch (e) {
//       debugPrint(
//         'GET VERSION DIO ERROR: ${e.message}',
//       );
//     } catch (e) {
//       debugPrint(
//         'GET VERSION ERROR: $e',
//       );
//     }

//     return '';
//   }

//   // ---------------------------------------------------------------------------
//   // PREPARE PHOTO AS PNG
//   // ---------------------------------------------------------------------------

//   Future<File?>
//       _preparePngFile(
//     String sourcePath,
//     String uniqueId,
//     String photoName,
//   ) async {
//     try {
//       final sourceFile =
//           File(sourcePath);

//       if (!await sourceFile.exists()) {
//         debugPrint(
//           '$photoName does not exist: $sourcePath',
//         );

//         return null;
//       }

//       final outputDirectory =
//           Directory(
//         path.join(
//           sourceFile.parent.path,
//           'sync_png',
//         ),
//       );

//       if (!await outputDirectory
//           .exists()) {
//         await outputDirectory.create(
//           recursive: true,
//         );
//       }

//       final outputPath =
//           path.join(
//         outputDirectory.path,
//         '${uniqueId}_$photoName.png',
//       );

//       final result =
//           await FlutterImageCompress
//               .compressAndGetFile(
//         sourceFile.path,
//         outputPath,
//         format:
//             CompressFormat.png,
//       );

//       if (result == null) {
//         debugPrint(
//           '$photoName PNG conversion failed.',
//         );

//         return null;
//       }

//       debugPrint(
//         '$photoName PNG CREATED: ${result.path}',
//       );

//       return File(
//         result.path,
//       );
//     } catch (e) {
//       debugPrint(
//         '$photoName PNG PREPARATION ERROR: $e',
//       );

//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // VALUE HELPER
//   // ---------------------------------------------------------------------------

//   String _value(
//     Map<String, dynamic> data,
//     String key,
//   ) {
//     final value =
//         data[key];

//     if (value == null) {
//       return '';
//     }

//     return value.toString();
//   }

//   // ---------------------------------------------------------------------------
//   // VALID PHOTO PATH
//   // ---------------------------------------------------------------------------

//   String? _validPath(
//     String value,
//   ) {
//     final trimmed =
//         value.trim();

//     if (trimmed.isEmpty) {
//       return null;
//     }

//     return trimmed;
//   }

//   // ---------------------------------------------------------------------------
//   // REFRESH
//   // ---------------------------------------------------------------------------

//   Future<void> refresh() async {
//     if (isSyncing.value) {
//       return;
//     }

//     await loadPendingData();
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../database/database_helper.dart';

class SyncDataController extends GetxController {
  final DatabaseHelper database = DatabaseHelper.instance;

  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 180),
    ),
  );

  // ---------------------------------------------------------------------------
  // API CONFIGURATION
  // ---------------------------------------------------------------------------

  static const String syncUrl =
      'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

  // IMPORTANT:
  // The previously configured version URL returned HTTP 404.
  // Replace it with the correct, working version API URL.
  static const String versionUrl =
      'https://kgis.ksrsac.in/api/app/version';

  static const String applicantId =
      '1_Insert_Handloom_Data_Trans';

  static const String parameter =
      r'P1$|$P2$|$P3$|$P4$|$P5$|$P6$|$P7$|$P8$|$P9$|$P10$|$P11$|$P12$|$P13$|$P14$|$P15$|$P16$|$P17$|$P100';

  // ---------------------------------------------------------------------------
  // OBSERVABLES
  // ---------------------------------------------------------------------------

  final RxList<Map<String, dynamic>> pendingData =
      <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isSyncing = false.obs;

  final RxInt totalCount = 0.obs;
  final RxInt successCount = 0.obs;
  final RxInt failedCount = 0.obs;

  final RxString currentUniqueId = ''.obs;

  final RxString statusMessage =
      'Loading pending data...'.obs;

  @override
  void onInit() {
    super.onInit();
    loadPendingData();
  }

  // ---------------------------------------------------------------------------
  // LOAD PENDING DATA
  // ---------------------------------------------------------------------------

  Future<void> loadPendingData({
    bool force = false,
  }) async {
    if (isSyncing.value && !force) {
      return;
    }

    try {
      isLoading.value = true;

      final data = await database.getPendingSurveys();

      pendingData.assignAll(
        data.map(
          (item) => Map<String, dynamic>.from(item),
        ),
      );

      totalCount.value = pendingData.length;

      statusMessage.value = pendingData.isEmpty
          ? 'No pending data available.'
          : '${pendingData.length} pending record(s) available.';

      debugPrint(
        'PENDING RECORD COUNT: ${pendingData.length}',
      );
    } catch (e, stackTrace) {
      debugPrint('LOAD PENDING DATA ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      statusMessage.value = 'Unable to load pending data.';

      Get.snackbar(
        'Error',
        'Unable to load pending data.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // SYNCHRONIZE ALL PENDING RECORDS
  // ---------------------------------------------------------------------------

  Future<void> syncAllData() async {
    if (isSyncing.value) {
      return;
    }

    await loadPendingData();

    if (pendingData.isEmpty) {
      Get.snackbar(
        'Sync Data',
        'No pending data available for synchronization.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSyncing.value = true;

    successCount.value = 0;
    failedCount.value = 0;

    statusMessage.value = 'Getting application version...';

    try {
      final syncedVersion = await _getLatestAppVersion();

      debugPrint('SYNC APP VERSION: $syncedVersion');

      final records = pendingData
          .map(
            (item) => Map<String, dynamic>.from(item),
          )
          .toList();

      for (int i = 0; i < records.length; i++) {
        final survey = records[i];
        final uniqueId = _value(survey, 'p1');

        currentUniqueId.value = uniqueId;

        statusMessage.value =
            'Syncing ${i + 1} of ${records.length}';

        debugPrint(
          'SYNCING RECORD ${i + 1}/${records.length}: $uniqueId',
        );

        final success = await _syncSingleSurvey(
          survey,
          syncedVersion,
        );

        if (success) {
          successCount.value++;
        } else {
          failedCount.value++;
        }
      }

      currentUniqueId.value = '';

      statusMessage.value = 'Refreshing pending records...';

      // Force a database refresh while the sync operation is still active.
      await loadPendingData(force: true);

      if (failedCount.value == 0) {
        statusMessage.value =
            'Synchronization completed successfully.';

        Get.snackbar(
          'Sync Completed',
          '${successCount.value} record(s) synchronized successfully.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
        );
      } else {
        statusMessage.value =
            'Synchronization completed with some failures.';

        Get.snackbar(
          'Sync Completed',
          '${successCount.value} succeeded, '
              '${failedCount.value} failed.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('SYNC ALL ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      statusMessage.value = 'Synchronization failed.';

      Get.snackbar(
        'Sync Error',
        'Unable to complete synchronization.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      currentUniqueId.value = '';
      isSyncing.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // SYNCHRONIZE ONE SURVEY
  // ---------------------------------------------------------------------------

  Future<bool> _syncSingleSurvey(
    Map<String, dynamic> survey,
    String syncedVersion,
  ) async {
    final p1 = _value(survey, 'p1');

    try {
      final p2 = _value(survey, 'p2');
      final p3 = _value(survey, 'p3');
      final p4 = _value(survey, 'p4');
      final p5 = _value(survey, 'p5');
      final p6 = _value(survey, 'p6');
      final p7 = _value(survey, 'p7');
      final p8 = _value(survey, 'p8');
      final p9 = _value(survey, 'p9');
      final p10 = _value(survey, 'p10');
      final p11 = _value(survey, 'p11');
      final p12 = _value(survey, 'p12');
      final p13 = _value(survey, 'p13');
      final p14 = _value(survey, 'p14');
      final p15 = _value(survey, 'p15');

      // P16 contains the server application version.
      final p16 = syncedVersion;

      final p17 = _value(survey, 'p17');
      final p100 = _value(survey, 'p100');

      // P101 is intentionally excluded.
      final values = <String>[
        p1,
        p2,
        p3,
        p4,
        p5,
        p6,
        p7,
        p8,
        p9,
        p10,
        p11,
        p12,
        p13,
        p14,
        p15,
        p16,
        p17,
        p100,
      ].join(r'$|$');

      debugPrint('--------------------------------------------------');
      debugPrint('SYNC UNIQUE ID: $p1');
      debugPrint('SYNC APPLICANT ID: $applicantId');
      debugPrint('SYNC PARAMETERS: $parameter');
      debugPrint('SYNC VALUES: $values');

      // -----------------------------------------------------------------------
      // MULTIPART FORM DATA
      // -----------------------------------------------------------------------

      final formData = dio.FormData.fromMap({
        'applicantId': applicantId,
        'parameter': parameter,
        'values': values,
      });

      // -----------------------------------------------------------------------
      // PHOTO 1: P8
      // -----------------------------------------------------------------------

      final photo1Path = _validPath(p8);

      if (photo1Path != null) {
        final photo1File = await _preparePngFile(
          photo1Path,
          p1,
          'photo1',
        );

        if (photo1File != null) {
          formData.files.add(
            MapEntry(
              'photo1',
              await dio.MultipartFile.fromFile(
                photo1File.path,
                filename: '${p1}_photo1.png',
              ),
            ),
          );

          debugPrint('PHOTO 1 ATTACHED');
        } else {
          debugPrint('PHOTO 1 COULD NOT BE PREPARED: $p1');
        }
      } else {
        debugPrint('PHOTO 1 PATH IS EMPTY: $p1');
      }

      // -----------------------------------------------------------------------
      // PHOTO 2: P9
      // -----------------------------------------------------------------------

      final photo2Path = _validPath(p9);

      if (photo2Path != null) {
        final photo2File = await _preparePngFile(
          photo2Path,
          p1,
          'photo2',
        );

        if (photo2File != null) {
          formData.files.add(
            MapEntry(
              'photo2',
              await dio.MultipartFile.fromFile(
                photo2File.path,
                filename: '${p1}_photo2.png',
              ),
            ),
          );

          debugPrint('PHOTO 2 ATTACHED');
        } else {
          debugPrint('PHOTO 2 COULD NOT BE PREPARED: $p1');
        }
      } else {
        debugPrint('PHOTO 2 PATH IS EMPTY: $p1');
      }

      // -----------------------------------------------------------------------
      // SEND REQUEST
      // -----------------------------------------------------------------------

      final dio.Response response = await _dio.post(
        syncUrl,
        data: formData,
        options: dio.Options(
          contentType: 'multipart/form-data',
          responseType: dio.ResponseType.json,
        ),
      );

      debugPrint('SYNC HTTP STATUS: ${response.statusCode}');
      debugPrint('SYNC RESPONSE: ${response.data}');

      // -----------------------------------------------------------------------
      // PROCESS RESPONSE
      // -----------------------------------------------------------------------

      if (_isSuccessfulResponse(response)) {
        // Update the version and status only after a successful server response.
        await database.updateSyncedVersion(
          p1,
          syncedVersion,
        );

        await database.updateSyncStatus(
          p1,
          'Synced',
        );

        debugPrint('SYNC SUCCESS: $p1');

        return true;
      }

      await database.updateSyncStatus(
        p1,
        'Pending',
      );

      debugPrint('SYNC FAILED: $p1');

      return false;
    } on dio.DioException catch (e, stackTrace) {
      debugPrint('DIO SYNC ERROR [$p1]');
      debugPrint('TYPE: ${e.type}');
      debugPrint('MESSAGE: ${e.message}');
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('RESPONSE: ${e.response?.data}');
      debugPrintStack(stackTrace: stackTrace);

      await _markPendingSafely(p1);

      return false;
    } catch (e, stackTrace) {
      debugPrint('SYNC ERROR [$p1]: $e');
      debugPrintStack(stackTrace: stackTrace);

      await _markPendingSafely(p1);

      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // SUCCESS RESPONSE CHECK
  //
  // Supports responses such as:
  // [{ "StatusCode": 200, "StatusMessage": "Inserted Successfully ( Ack - 6 )" }]
  //
  // Also supports a Map response and a plain-text response.
  // ---------------------------------------------------------------------------

  bool _isSuccessfulResponse(
    dio.Response response,
  ) {
    final httpStatus = response.statusCode;

    if (httpStatus != 200 && httpStatus != 201) {
      debugPrint('SYNC HTTP FAILURE: $httpStatus');
      return false;
    }

    final data = response.data;

    // The API may return a list containing one or more status maps.
    if (data is List) {
      if (data.isEmpty) {
        debugPrint('SYNC RESPONSE LIST IS EMPTY');
        return false;
      }

      for (final item in data) {
        if (item is Map) {
          if (_isSuccessfulStatusMap(item)) {
            return true;
          }
        } else if (item is String && _isSuccessMessage(item)) {
          return true;
        }
      }

      return false;
    }

    // The API may return a single map.
    if (data is Map) {
      return _isSuccessfulStatusMap(data);
    }

    // The API may return plain text.
    if (data is String) {
      return _isSuccessMessage(data);
    }

    debugPrint(
      'UNRECOGNIZED SYNC RESPONSE TYPE: ${data.runtimeType}',
    );

    return false;
  }

  bool _isSuccessfulStatusMap(Map<dynamic, dynamic> data) {
    final success = _getMapValue(
      data,
      const ['success', 'isSuccess'],
    );

    if (success == true ||
        success?.toString().toLowerCase() == 'true') {
      return true;
    }

    final codeValue = _getMapValue(
      data,
      const ['StatusCode', 'statusCode', 'status_code'],
    );

    final code = int.tryParse(codeValue?.toString() ?? '');

    final messageValue = _getMapValue(
      data,
      const [
        'StatusMessage',
        'statusMessage',
        'message',
        'Message',
      ],
    );

    final message = messageValue?.toString() ?? '';

    debugPrint('SYNC RESPONSE STATUS CODE: $code');
    debugPrint('SYNC RESPONSE MESSAGE: $message');

    // For this API, successful insertion is returned as:
    // StatusCode: 200
    // StatusMessage: Inserted Successfully (...)
    if (code == 200 || code == 201) {
      if (message.isEmpty) {
        return true;
      }

      return _isSuccessMessage(message);
    }

    final statusValue = _getMapValue(
      data,
      const ['status', 'Status'],
    );

    final status = statusValue?.toString().toLowerCase();

    if (status == 'success' || status == 'true') {
      return true;
    }

    // Support generic APIs returning a success message without a status code.
    if (code == null && _isSuccessMessage(message)) {
      return true;
    }

    return false;
  }

  dynamic _getMapValue(
    Map<dynamic, dynamic> data,
    List<String> possibleKeys,
  ) {
    for (final key in possibleKeys) {
      if (data.containsKey(key)) {
        return data[key];
      }
    }

    // Also support different key capitalization.
    for (final entry in data.entries) {
      final actualKey = entry.key.toString().toLowerCase();

      for (final key in possibleKeys) {
        if (actualKey == key.toLowerCase()) {
          return entry.value;
        }
      }
    }

    return null;
  }

  bool _isSuccessMessage(String message) {
    final text = message.trim().toLowerCase();

    if (text.isEmpty) {
      return false;
    }

    // Explicit failure messages must not be treated as success.
    if (text.contains('failed') ||
        text.contains('failure') ||
        text.contains('error') ||
        text.contains('not inserted') ||
        text.contains('unsuccessful')) {
      return false;
    }

    return text.contains('success') ||
        text.contains('inserted') ||
        text.contains('saved');
  }

  // ---------------------------------------------------------------------------
  // FETCH SERVER APPLICATION VERSION
  // ---------------------------------------------------------------------------

  Future<String> _getLatestAppVersion() async {
    try {
      final dio.Response response = await _dio.get(
        versionUrl,
        options: dio.Options(
          responseType: dio.ResponseType.json,
        ),
      );

      debugPrint('VERSION API STATUS: ${response.statusCode}');
      debugPrint('VERSION API RESPONSE: ${response.data}');

      final data = response.data;

      if (data is Map) {
        // Expected response:
        // {
        //   "success": true,
        //   "data": {
        //     "appVersion": "1.0.1"
        //   }
        // }

        final nestedData = _getMapValue(
          data,
          const ['data'],
        );

        if (nestedData is Map) {
          final version = _getMapValue(
            nestedData,
            const ['appVersion', 'AppVersion', 'version'],
          );

          if (version != null &&
              version.toString().trim().isNotEmpty) {
            return version.toString().trim();
          }
        }

        // Also support a top-level version property.
        final version = _getMapValue(
          data,
          const ['appVersion', 'AppVersion', 'version'],
        );

        if (version != null &&
            version.toString().trim().isNotEmpty) {
          return version.toString().trim();
        }
      }

      debugPrint('APP VERSION NOT FOUND IN VERSION RESPONSE');
    } on dio.DioException catch (e) {
      debugPrint('GET VERSION DIO ERROR: ${e.message}');
      debugPrint('GET VERSION HTTP STATUS: ${e.response?.statusCode}');
      debugPrint('GET VERSION RESPONSE: ${e.response?.data}');
    } catch (e, stackTrace) {
      debugPrint('GET VERSION ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    // Do not invent a version if the API is unavailable.
    return '';
  }

  // ---------------------------------------------------------------------------
  // PREPARE PHOTO AS PNG
  // ---------------------------------------------------------------------------

  Future<File?> _preparePngFile(
    String sourcePath,
    String uniqueId,
    String photoName,
  ) async {
    try {
      final sourceFile = File(sourcePath);

      if (!await sourceFile.exists()) {
        debugPrint(
          '$photoName DOES NOT EXIST: $sourcePath',
        );
        return null;
      }

      final outputDirectory = Directory(
        path.join(
          sourceFile.parent.path,
          'sync_png',
        ),
      );

      if (!await outputDirectory.exists()) {
        await outputDirectory.create(
          recursive: true,
        );
      }

      final outputPath = path.join(
        outputDirectory.path,
        '${uniqueId}_$photoName.png',
      );

      final result =
          await FlutterImageCompress.compressAndGetFile(
        sourceFile.path,
        outputPath,
        format: CompressFormat.png,
      );

      if (result == null) {
        debugPrint('$photoName PNG CONVERSION FAILED');
        return null;
      }

      final convertedFile = File(result.path);

      if (!await convertedFile.exists()) {
        debugPrint('$photoName CONVERTED FILE NOT FOUND');
        return null;
      }

      debugPrint(
        '$photoName PNG CREATED: ${result.path}',
      );

      return convertedFile;
    } catch (e, stackTrace) {
      debugPrint('$photoName PNG PREPARATION ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // DATABASE STATUS HELPER
  // ---------------------------------------------------------------------------

  Future<void> _markPendingSafely(String uniqueId) async {
    try {
      await database.updateSyncStatus(
        uniqueId,
        'Pending',
      );
    } catch (e) {
      debugPrint(
        'FAILED TO MARK RECORD AS PENDING [$uniqueId]: $e',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // VALUE HELPER
  // ---------------------------------------------------------------------------

  String _value(
    Map<String, dynamic> data,
    String key,
  ) {
    dynamic value = data[key];

    // Support database column names with different capitalization.
    if (value == null) {
      for (final entry in data.entries) {
        if (entry.key.toString().toLowerCase() ==
            key.toLowerCase()) {
          value = entry.value;
          break;
        }
      }
    }

    return value?.toString() ?? '';
  }

  // ---------------------------------------------------------------------------
  // VALID PHOTO PATH
  // ---------------------------------------------------------------------------

  String? _validPath(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return null;
    }

    return trimmed;
  }

  // ---------------------------------------------------------------------------
  // REFRESH
  // ---------------------------------------------------------------------------

  Future<void> refresh() async {
    if (isSyncing.value) {
      return;
    }

    await loadPendingData();
  }
}