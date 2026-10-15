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

// import 'dart:io';

// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/foundation.dart';
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
//   // API CONFIGURATION
//   // ---------------------------------------------------------------------------

//   static const String syncUrl =
//       'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

//   // IMPORTANT:
//   // The previously configured version URL returned HTTP 404.
//   // Replace it with the correct, working version API URL.
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

//   Future<void> loadPendingData({
//     bool force = false,
//   }) async {
//     if (isSyncing.value && !force) {
//       return;
//     }

//     try {
//       isLoading.value = true;

//       final data = await database.getPendingSurveys();

//       pendingData.assignAll(
//         data.map(
//           (item) => Map<String, dynamic>.from(item),
//         ),
//       );

//       totalCount.value = pendingData.length;

//       statusMessage.value = pendingData.isEmpty
//           ? 'No pending data available.'
//           : '${pendingData.length} pending record(s) available.';

//       debugPrint(
//         'PENDING RECORD COUNT: ${pendingData.length}',
//       );
//     } catch (e, stackTrace) {
//       debugPrint('LOAD PENDING DATA ERROR: $e');
//       debugPrintStack(stackTrace: stackTrace);

//       statusMessage.value = 'Unable to load pending data.';

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
//   // SYNCHRONIZE ALL PENDING RECORDS
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
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     isSyncing.value = true;

//     successCount.value = 0;
//     failedCount.value = 0;

//     statusMessage.value = 'Getting application version...';

//     try {
//       final syncedVersion = await _getLatestAppVersion();

//       debugPrint('SYNC APP VERSION: $syncedVersion');

//       final records = pendingData
//           .map(
//             (item) => Map<String, dynamic>.from(item),
//           )
//           .toList();

//       for (int i = 0; i < records.length; i++) {
//         final survey = records[i];
//         final uniqueId = _value(survey, 'p1');

//         currentUniqueId.value = uniqueId;

//         statusMessage.value =
//             'Syncing ${i + 1} of ${records.length}';

//         debugPrint(
//           'SYNCING RECORD ${i + 1}/${records.length}: $uniqueId',
//         );

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

//       currentUniqueId.value = '';

//       statusMessage.value = 'Refreshing pending records...';

//       // Force a database refresh while the sync operation is still active.
//       await loadPendingData(force: true);

//       if (failedCount.value == 0) {
//         statusMessage.value =
//             'Synchronization completed successfully.';

//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} record(s) synchronized successfully.',
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 4),
//         );
//       } else {
//         statusMessage.value =
//             'Synchronization completed with some failures.';

//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} succeeded, '
//               '${failedCount.value} failed.',
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 5),
//         );
//       }
//     } catch (e, stackTrace) {
//       debugPrint('SYNC ALL ERROR: $e');
//       debugPrintStack(stackTrace: stackTrace);

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
//   // SYNCHRONIZE ONE SURVEY
//   // ---------------------------------------------------------------------------

//   Future<bool> _syncSingleSurvey(
//     Map<String, dynamic> survey,
//     String syncedVersion,
//   ) async {
//     final p1 = _value(survey, 'p1');

//     try {
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

//       // P16 contains the server application version.
//       final p16 = syncedVersion;

//       final p17 = _value(survey, 'p17');
//       final p100 = _value(survey, 'p100');

//       // P101 is intentionally excluded.
//       final values = <String>[
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

//       debugPrint('--------------------------------------------------');
//       debugPrint('SYNC UNIQUE ID: $p1');
//       debugPrint('SYNC APPLICANT ID: $applicantId');
//       debugPrint('SYNC PARAMETERS: $parameter');
//       debugPrint('SYNC VALUES: $values');

//       // -----------------------------------------------------------------------
//       // MULTIPART FORM DATA
//       // -----------------------------------------------------------------------

//       final formData = dio.FormData.fromMap({
//         'applicantId': applicantId,
//         'parameter': parameter,
//         'values': values,
//       });

//       // -----------------------------------------------------------------------
//       // PHOTO 1: P8
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
//               await dio.MultipartFile.fromFile(
//                 photo1File.path,
//                 filename: '${p1}_photo1.png',
//               ),
//             ),
//           );

//           debugPrint('PHOTO 1 ATTACHED');
//         } else {
//           debugPrint('PHOTO 1 COULD NOT BE PREPARED: $p1');
//         }
//       } else {
//         debugPrint('PHOTO 1 PATH IS EMPTY: $p1');
//       }

//       // -----------------------------------------------------------------------
//       // PHOTO 2: P9
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
//               await dio.MultipartFile.fromFile(
//                 photo2File.path,
//                 filename: '${p1}_photo2.png',
//               ),
//             ),
//           );

//           debugPrint('PHOTO 2 ATTACHED');
//         } else {
//           debugPrint('PHOTO 2 COULD NOT BE PREPARED: $p1');
//         }
//       } else {
//         debugPrint('PHOTO 2 PATH IS EMPTY: $p1');
//       }

//       // -----------------------------------------------------------------------
//       // SEND REQUEST
//       // -----------------------------------------------------------------------

//       final dio.Response response = await _dio.post(
//         syncUrl,
//         data: formData,
//         options: dio.Options(
//           contentType: 'multipart/form-data',
//           responseType: dio.ResponseType.json,
//         ),
//       );

//       debugPrint('SYNC HTTP STATUS: ${response.statusCode}');
//       debugPrint('SYNC RESPONSE: ${response.data}');

//       // -----------------------------------------------------------------------
//       // PROCESS RESPONSE
//       // -----------------------------------------------------------------------

//       if (_isSuccessfulResponse(response)) {
//         // Update the version and status only after a successful server response.
//         await database.updateSyncedVersion(
//           p1,
//           syncedVersion,
//         );

//         await database.updateSyncStatus(
//           p1,
//           'Synced',
//         );

//         debugPrint('SYNC SUCCESS: $p1');

//         return true;
//       }

//       await database.updateSyncStatus(
//         p1,
//         'Pending',
//       );

//       debugPrint('SYNC FAILED: $p1');

//       return false;
//     } on dio.DioException catch (e, stackTrace) {
//       debugPrint('DIO SYNC ERROR [$p1]');
//       debugPrint('TYPE: ${e.type}');
//       debugPrint('MESSAGE: ${e.message}');
//       debugPrint('STATUS: ${e.response?.statusCode}');
//       debugPrint('RESPONSE: ${e.response?.data}');
//       debugPrintStack(stackTrace: stackTrace);

//       await _markPendingSafely(p1);

//       return false;
//     } catch (e, stackTrace) {
//       debugPrint('SYNC ERROR [$p1]: $e');
//       debugPrintStack(stackTrace: stackTrace);

//       await _markPendingSafely(p1);

//       return false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // SUCCESS RESPONSE CHECK
//   //
//   // Supports responses such as:
//   // [{ "StatusCode": 200, "StatusMessage": "Inserted Successfully ( Ack - 6 )" }]
//   //
//   // Also supports a Map response and a plain-text response.
//   // ---------------------------------------------------------------------------

//   bool _isSuccessfulResponse(
//     dio.Response response,
//   ) {
//     final httpStatus = response.statusCode;

//     if (httpStatus != 200 && httpStatus != 201) {
//       debugPrint('SYNC HTTP FAILURE: $httpStatus');
//       return false;
//     }

//     final data = response.data;

//     // The API may return a list containing one or more status maps.
//     if (data is List) {
//       if (data.isEmpty) {
//         debugPrint('SYNC RESPONSE LIST IS EMPTY');
//         return false;
//       }

//       for (final item in data) {
//         if (item is Map) {
//           if (_isSuccessfulStatusMap(item)) {
//             return true;
//           }
//         } else if (item is String && _isSuccessMessage(item)) {
//           return true;
//         }
//       }

//       return false;
//     }

//     // The API may return a single map.
//     if (data is Map) {
//       return _isSuccessfulStatusMap(data);
//     }

//     // The API may return plain text.
//     if (data is String) {
//       return _isSuccessMessage(data);
//     }

//     debugPrint(
//       'UNRECOGNIZED SYNC RESPONSE TYPE: ${data.runtimeType}',
//     );

//     return false;
//   }

//   bool _isSuccessfulStatusMap(Map<dynamic, dynamic> data) {
//     final success = _getMapValue(
//       data,
//       const ['success', 'isSuccess'],
//     );

//     if (success == true ||
//         success?.toString().toLowerCase() == 'true') {
//       return true;
//     }

//     final codeValue = _getMapValue(
//       data,
//       const ['StatusCode', 'statusCode', 'status_code'],
//     );

//     final code = int.tryParse(codeValue?.toString() ?? '');

//     final messageValue = _getMapValue(
//       data,
//       const [
//         'StatusMessage',
//         'statusMessage',
//         'message',
//         'Message',
//       ],
//     );

//     final message = messageValue?.toString() ?? '';

//     debugPrint('SYNC RESPONSE STATUS CODE: $code');
//     debugPrint('SYNC RESPONSE MESSAGE: $message');

//     // For this API, successful insertion is returned as:
//     // StatusCode: 200
//     // StatusMessage: Inserted Successfully (...)
//     if (code == 200 || code == 201) {
//       if (message.isEmpty) {
//         return true;
//       }

//       return _isSuccessMessage(message);
//     }

//     final statusValue = _getMapValue(
//       data,
//       const ['status', 'Status'],
//     );

//     final status = statusValue?.toString().toLowerCase();

//     if (status == 'success' || status == 'true') {
//       return true;
//     }

//     // Support generic APIs returning a success message without a status code.
//     if (code == null && _isSuccessMessage(message)) {
//       return true;
//     }

//     return false;
//   }

//   dynamic _getMapValue(
//     Map<dynamic, dynamic> data,
//     List<String> possibleKeys,
//   ) {
//     for (final key in possibleKeys) {
//       if (data.containsKey(key)) {
//         return data[key];
//       }
//     }

//     // Also support different key capitalization.
//     for (final entry in data.entries) {
//       final actualKey = entry.key.toString().toLowerCase();

//       for (final key in possibleKeys) {
//         if (actualKey == key.toLowerCase()) {
//           return entry.value;
//         }
//       }
//     }

//     return null;
//   }

//   bool _isSuccessMessage(String message) {
//     final text = message.trim().toLowerCase();

//     if (text.isEmpty) {
//       return false;
//     }

//     // Explicit failure messages must not be treated as success.
//     if (text.contains('failed') ||
//         text.contains('failure') ||
//         text.contains('error') ||
//         text.contains('not inserted') ||
//         text.contains('unsuccessful')) {
//       return false;
//     }

//     return text.contains('success') ||
//         text.contains('inserted') ||
//         text.contains('saved');
//   }

//   // ---------------------------------------------------------------------------
//   // FETCH SERVER APPLICATION VERSION
//   // ---------------------------------------------------------------------------

//   Future<String> _getLatestAppVersion() async {
//     try {
//       final dio.Response response = await _dio.get(
//         versionUrl,
//         options: dio.Options(
//           responseType: dio.ResponseType.json,
//         ),
//       );

//       debugPrint('VERSION API STATUS: ${response.statusCode}');
//       debugPrint('VERSION API RESPONSE: ${response.data}');

//       final data = response.data;

//       if (data is Map) {
//         // Expected response:
//         // {
//         //   "success": true,
//         //   "data": {
//         //     "appVersion": "1.0.1"
//         //   }
//         // }

//         final nestedData = _getMapValue(
//           data,
//           const ['data'],
//         );

//         if (nestedData is Map) {
//           final version = _getMapValue(
//             nestedData,
//             const ['appVersion', 'AppVersion', 'version'],
//           );

//           if (version != null &&
//               version.toString().trim().isNotEmpty) {
//             return version.toString().trim();
//           }
//         }

//         // Also support a top-level version property.
//         final version = _getMapValue(
//           data,
//           const ['appVersion', 'AppVersion', 'version'],
//         );

//         if (version != null &&
//             version.toString().trim().isNotEmpty) {
//           return version.toString().trim();
//         }
//       }

//       debugPrint('APP VERSION NOT FOUND IN VERSION RESPONSE');
//     } on dio.DioException catch (e) {
//       debugPrint('GET VERSION DIO ERROR: ${e.message}');
//       debugPrint('GET VERSION HTTP STATUS: ${e.response?.statusCode}');
//       debugPrint('GET VERSION RESPONSE: ${e.response?.data}');
//     } catch (e, stackTrace) {
//       debugPrint('GET VERSION ERROR: $e');
//       debugPrintStack(stackTrace: stackTrace);
//     }

//     // Do not invent a version if the API is unavailable.
//     return '';
//   }

//   // ---------------------------------------------------------------------------
//   // PREPARE PHOTO AS PNG
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
//           '$photoName DOES NOT EXIST: $sourcePath',
//         );
//         return null;
//       }

//       final outputDirectory = Directory(
//         path.join(
//           sourceFile.parent.path,
//           'sync_png',
//         ),
//       );

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
//         debugPrint('$photoName PNG CONVERSION FAILED');
//         return null;
//       }

//       final convertedFile = File(result.path);

//       if (!await convertedFile.exists()) {
//         debugPrint('$photoName CONVERTED FILE NOT FOUND');
//         return null;
//       }

//       debugPrint(
//         '$photoName PNG CREATED: ${result.path}',
//       );

//       return convertedFile;
//     } catch (e, stackTrace) {
//       debugPrint('$photoName PNG PREPARATION ERROR: $e');
//       debugPrintStack(stackTrace: stackTrace);
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // DATABASE STATUS HELPER
//   // ---------------------------------------------------------------------------

//   Future<void> _markPendingSafely(String uniqueId) async {
//     try {
//       await database.updateSyncStatus(
//         uniqueId,
//         'Pending',
//       );
//     } catch (e) {
//       debugPrint(
//         'FAILED TO MARK RECORD AS PENDING [$uniqueId]: $e',
//       );
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // VALUE HELPER
//   // ---------------------------------------------------------------------------

//   String _value(
//     Map<String, dynamic> data,
//     String key,
//   ) {
//     dynamic value = data[key];

//     // Support database column names with different capitalization.
//     if (value == null) {
//       for (final entry in data.entries) {
//         if (entry.key.toString().toLowerCase() ==
//             key.toLowerCase()) {
//           value = entry.value;
//           break;
//         }
//       }
//     }

//     return value?.toString() ?? '';
//   }

//   // ---------------------------------------------------------------------------
//   // VALID PHOTO PATH
//   // ---------------------------------------------------------------------------

//   String? _validPath(String value) {
//     final trimmed = value.trim();

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


// import 'dart:io';

// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:get/get.dart';
// import 'package:package_info_plus/package_info_plus.dart';
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
//   // API CONFIGURATION
//   // ---------------------------------------------------------------------------

//   static const String syncUrl =
//       'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

//   static const String applicantId =
//       '1_Insert_Handloom_Data_Trans';

//   // Exactly P1-P17 and P100. P101 is intentionally excluded.
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

//   // Installed version, e.g. 1.0.0.
//   String installedAppVersion = '';

//   // ---------------------------------------------------------------------------
//   // INIT
//   // ---------------------------------------------------------------------------

//   @override
//   void onInit() {
//     super.onInit();
//     loadPendingData();
//   }

//   // ---------------------------------------------------------------------------
//   // GET INSTALLED APP VERSION
//   // ---------------------------------------------------------------------------

//   Future<String> _getInstalledAppVersion() async {
//     final PackageInfo packageInfo =
//         await PackageInfo.fromPlatform();

//     final String version = packageInfo.version.trim();

//     debugPrint('PACKAGE NAME: ${packageInfo.packageName}');
//     debugPrint('INSTALLED APP VERSION: $version');

//     if (version.isEmpty) {
//       throw Exception(
//         'Installed app version is empty. Cannot synchronize data.',
//       );
//     }

//     return version;
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

//       final List<Map<String, dynamic>> data =
//           await database.getPendingSurveys();

//       pendingData.assignAll(
//         data
//             .map(
//               (item) => Map<String, dynamic>.from(item),
//             )
//             .toList(),
//       );

//       totalCount.value = pendingData.length;

//       statusMessage.value = pendingData.isEmpty
//           ? 'No pending data available.'
//           : '${pendingData.length} pending record(s) available.';

//       debugPrint(
//         'PENDING RECORD COUNT: ${pendingData.length}',
//       );
//     } catch (e, stackTrace) {
//       debugPrint('LOAD PENDING DATA ERROR: $e');
//       debugPrint('$stackTrace');

//       statusMessage.value = 'Unable to load pending data.';

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
//   // START SYNCHRONIZATION
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
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     isSyncing.value = true;
//     successCount.value = 0;
//     failedCount.value = 0;

//     statusMessage.value = 'Getting installed app version...';

//     try {
//       // IMPORTANT:
//       // Use the version installed on this device.
//       // Do not call the old server version endpoint, which returned empty.
//       installedAppVersion = await _getInstalledAppVersion();

//       debugPrint('SYNC APP VERSION: $installedAppVersion');

//       // Take a snapshot because successful records will be removed from
//       // pendingData as they are deleted from SQLite.
//       final List<Map<String, dynamic>> records =
//           pendingData
//               .map(
//                 (item) => Map<String, dynamic>.from(item),
//               )
//               .toList();

//       for (int i = 0; i < records.length; i++) {
//         final Map<String, dynamic> survey = records[i];
//         final String uniqueId = _value(survey, 'p1');

//         currentUniqueId.value = uniqueId;

//         statusMessage.value =
//             'Syncing ${i + 1} of ${records.length}';

//         debugPrint(
//           'SYNCING RECORD ${i + 1}/${records.length}: $uniqueId',
//         );

//         final bool success = await _syncSingleSurvey(
//           survey,
//           installedAppVersion,
//         );

//         if (success) {
//           successCount.value++;
//         } else {
//           failedCount.value++;
//         }
//       }

//       // Reload from SQLite so the displayed list matches the database.
//       await loadPendingData();

//       currentUniqueId.value = '';

//       if (failedCount.value == 0) {
//         statusMessage.value =
//             'Synchronization completed successfully.';

//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} record(s) uploaded successfully.',
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 4),
//         );
//       } else {
//         statusMessage.value =
//             'Synchronization completed with some failures.';

//         Get.snackbar(
//           'Sync Completed',
//           '${successCount.value} succeeded, '
//               '${failedCount.value} failed. Failed records remain saved for retry.',
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 6),
//         );
//       }
//     } catch (e, stackTrace) {
//       debugPrint('SYNC ALL ERROR: $e');
//       debugPrint('$stackTrace');

//       statusMessage.value = 'Synchronization failed.';

//       Get.snackbar(
//         'Sync Error',
//         'Unable to complete synchronization. Your saved records have been retained.',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 5),
//       );
//     } finally {
//       currentUniqueId.value = '';
//       isSyncing.value = false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // SYNC A SINGLE SURVEY
//   // ---------------------------------------------------------------------------

//   Future<bool> _syncSingleSurvey(
//     Map<String, dynamic> survey,
//     String syncedVersion,
//   ) async {
//     final String p1 = _value(survey, 'p1');

//     if (p1.isEmpty) {
//       debugPrint('SYNC FAILED: Survey has an empty P1 identifier.');
//       return false;
//     }

//     try {
//       // -----------------------------------------------------------------------
//       // READ VALUES
//       // -----------------------------------------------------------------------

//       final String p2 = _value(survey, 'p2');
//       final String p3 = _value(survey, 'p3');
//       final String p4 = _value(survey, 'p4');
//       final String p5 = _value(survey, 'p5');
//       final String p6 = _value(survey, 'p6');
//       final String p7 = _value(survey, 'p7');
//       final String p8 = _value(survey, 'p8');
//       final String p9 = _value(survey, 'p9');
//       final String p10 = _value(survey, 'p10');
//       final String p11 = _value(survey, 'p11');
//       final String p12 = _value(survey, 'p12');
//       final String p13 = _value(survey, 'p13');
//       final String p14 = _value(survey, 'p14');

//       // P15 is the version saved when the survey was collected.
//       final String p15 = _value(survey, 'p15');

//       // P16 is the version installed at synchronization time.
//       final String p16 = syncedVersion;

//       final String p17 = _value(survey, 'p17');
//       final String p100 = _value(survey, 'p100');

//       if (p16.trim().isEmpty) {
//         throw Exception(
//           'P16 is empty. Refusing to upload incomplete version data.',
//         );
//       }

//       // -----------------------------------------------------------------------
//       // SAVE P16 TO SQLITE BEFORE UPLOAD
//       // -----------------------------------------------------------------------

//       // This updates only P16. P15 remains unchanged.
//       final int updatedRows = await database.updateSurvey(
//         p1,
//         <String, dynamic>{
//           'p16': p16,
//         },
//       );

//       if (updatedRows == 0) {
//         // Do not upload if the version could not be saved locally.
//         throw Exception(
//           'Could not save P16 for survey $p1. Upload cancelled.',
//         );
//       }

//       // Keep the in-memory record consistent with SQLite.
//       survey['p16'] = p16;

//       debugPrint('SYNC UNIQUE ID: $p1');
//       debugPrint('SYNC APPLICANT ID: $applicantId');
//       debugPrint('P15 COLLECTION VERSION: $p15');
//       debugPrint('P16 SYNC VERSION: $p16');
//       debugPrint('SYNC PARAMETERS: $parameter');

//       // -----------------------------------------------------------------------
//       // BUILD VALUES IN THE EXACT REQUIRED ORDER
//       // -----------------------------------------------------------------------

//       final List<String> valuesList = <String>[
//         p1,   // P1
//         p2,   // P2
//         p3,   // P3
//         p4,   // P4
//         p5,   // P5
//         p6,   // P6
//         p7,   // P7
//         p8,   // P8
//         p9,   // P9
//         p10,  // P10
//         p11,  // P11
//         p12,  // P12
//         p13,  // P13
//         p14,  // P14
//         p15,  // P15
//         p16,  // P16
//         p17,  // P17
//         p100, // P100
//       ];

//       final String values = valuesList.join(r'$|$');

//       debugPrint('SYNC VALUES: $values');
//       debugPrint('SYNC VALUE COUNT: ${valuesList.length}');

//       if (valuesList.length != 18) {
//         throw Exception(
//           'Incorrect sync field count: ${valuesList.length}. Expected 18.',
//         );
//       }

//       // -----------------------------------------------------------------------
//       // CREATE MULTIPART FORM DATA
//       // -----------------------------------------------------------------------

//       final dio.FormData formData = dio.FormData.fromMap(
//         <String, dynamic>{
//           'applicantId': applicantId,
//           'parameter': parameter,
//           'values': values,
//         },
//       );

//       // -----------------------------------------------------------------------
//       // ATTACH PHOTO 1, IF AVAILABLE
//       // -----------------------------------------------------------------------

//       final String? photo1Path = _validPath(p8);

//       if (photo1Path != null) {
//         final File? photo1File = await _preparePngFile(
//           photo1Path,
//           p1,
//           'photo1',
//         );

//         if (photo1File != null) {
//           formData.files.add(
//             MapEntry<String, dio.MultipartFile>(
//               'photo1',
//               await dio.MultipartFile.fromFile(
//                 photo1File.path,
//                 filename: '${p1}_photo1.png',
//               ),
//             ),
//           );

//           debugPrint('PHOTO 1 ATTACHED: ${photo1File.path}');
//         } else {
//           debugPrint(
//             'PHOTO 1 NOT ATTACHED. Original path: $photo1Path',
//           );
//         }
//       } else {
//         debugPrint('PHOTO 1 PATH IS EMPTY.');
//       }

//       // -----------------------------------------------------------------------
//       // ATTACH PHOTO 2, IF AVAILABLE
//       // -----------------------------------------------------------------------

//       final String? photo2Path = _validPath(p9);

//       if (photo2Path != null) {
//         final File? photo2File = await _preparePngFile(
//           photo2Path,
//           p1,
//           'photo2',
//         );

//         if (photo2File != null) {
//           formData.files.add(
//             MapEntry<String, dio.MultipartFile>(
//               'photo2',
//               await dio.MultipartFile.fromFile(
//                 photo2File.path,
//                 filename: '${p1}_photo2.png',
//               ),
//             ),
//           );

//           debugPrint('PHOTO 2 ATTACHED: ${photo2File.path}');
//         } else {
//           debugPrint(
//             'PHOTO 2 NOT ATTACHED. Original path: $photo2Path',
//           );
//         }
//       } else {
//         debugPrint('PHOTO 2 PATH IS EMPTY.');
//       }

//       // -----------------------------------------------------------------------
//       // POST TO SERVER
//       // -----------------------------------------------------------------------

//       final dio.Response<dynamic> response = await _dio.post<dynamic>(
//         syncUrl,
//         data: formData,
//         options: dio.Options(
//           contentType: 'multipart/form-data',
//           responseType: dio.ResponseType.json,
//         ),
//       );

//       debugPrint('SYNC HTTP STATUS: ${response.statusCode}');
//       debugPrint('SYNC RESPONSE: ${response.data}');

//       // -----------------------------------------------------------------------
//       // CONFIRM SERVER SUCCESS
//       // -----------------------------------------------------------------------

//       if (!_isSuccessfulResponse(response)) {
//         debugPrint(
//           'SYNC NOT CONFIRMED. Keeping local record: $p1',
//         );

//         // Preserve the survey for retry.
//         await _safelyMarkPending(p1);

//         return false;
//       }

//       debugPrint(
//         'SERVER CONFIRMED SUCCESS FOR: $p1',
//       );

//       // -----------------------------------------------------------------------
//       // DELETE LOCAL RECORD ONLY AFTER CONFIRMED SERVER SUCCESS
//       // -----------------------------------------------------------------------

//       final int deletedRows = await database.deleteSurvey(p1);

//       if (deletedRows > 0) {
//         // Remove the uploaded record from the visible pending list.
//         pendingData.removeWhere(
//           (item) => _value(item, 'p1') == p1,
//         );

//         totalCount.value = pendingData.length;

//         debugPrint('LOCAL SURVEY DELETED: $p1');
//         debugPrint('REMAINING PENDING RECORDS: ${pendingData.length}');

//         return true;
//       }

//       // A server upload may have succeeded while local deletion failed.
//       // Do not report full completion when the row still exists.
//       final List<Map<String, dynamic>> remaining =
//           await database.getPendingSurveys();

//       final bool stillExists = remaining.any(
//         (item) => _value(item, 'p1') == p1,
//       );

//       if (!stillExists) {
//         pendingData.removeWhere(
//           (item) => _value(item, 'p1') == p1,
//         );

//         totalCount.value = pendingData.length;

//         debugPrint(
//           'LOCAL SURVEY WAS ALREADY REMOVED: $p1',
//         );

//         return true;
//       }

//       debugPrint(
//         'SERVER INSERTED $p1, BUT LOCAL ROW WAS NOT DELETED. '
//         'Check SQLite before retrying to avoid duplicate server records.',
//       );

//       return false;
//     } on dio.DioException catch (e, stackTrace) {
//       debugPrint('DIO SYNC ERROR [$p1]');
//       debugPrint('TYPE: ${e.type}');
//       debugPrint('MESSAGE: ${e.message}');
//       debugPrint('STATUS: ${e.response?.statusCode}');
//       debugPrint('RESPONSE: ${e.response?.data}');
//       debugPrint('$stackTrace');

//       // Keep the record available for retry.
//       await _safelyMarkPending(p1);

//       return false;
//     } catch (e, stackTrace) {
//       debugPrint('SYNC ERROR [$p1]: $e');
//       debugPrint('$stackTrace');

//       // Keep the record available for retry.
//       await _safelyMarkPending(p1);

//       return false;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // MARK A RECORD PENDING WITHOUT HIDING THE ORIGINAL ERROR
//   // ---------------------------------------------------------------------------

//   Future<void> _safelyMarkPending(String p1) async {
//     try {
//       await database.updateSyncStatus(p1, 'Pending');
//     } catch (e) {
//       debugPrint(
//         'COULD NOT UPDATE SYNC STATUS FOR $p1: $e',
//       );
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // CHECK SERVER RESPONSE
//   // ---------------------------------------------------------------------------

//   bool _isSuccessfulResponse(
//     dio.Response<dynamic> response,
//   ) {
//     final int? httpStatus = response.statusCode;

//     // The HTTP request itself must have succeeded.
//     if (httpStatus != 200 && httpStatus != 201) {
//       debugPrint(
//         'SERVER RESPONSE REJECTED: HTTP $httpStatus',
//       );
//       return false;
//     }

//     final dynamic data = response.data;

//     // The API has returned a list in this form:
//     // [
//     //   {
//     //     "StatusCode": 200,
//     //     "StatusMessage": "Inserted Successfully ( Ack - 6 )"
//     //   }
//     // ]
//     if (data is List) {
//       if (data.isEmpty) {
//         debugPrint('SERVER RETURNED AN EMPTY RESPONSE LIST.');
//         return false;
//       }

//       // Require every returned item to indicate success.
//       for (final dynamic item in data) {
//         if (!_isSuccessfulResponseItem(item)) {
//           debugPrint(
//             'SERVER RESPONSE ITEM DOES NOT CONFIRM SUCCESS: $item',
//           );
//           return false;
//         }
//       }

//       return true;
//     }

//     if (data is Map) {
//       return _isSuccessfulResponseItem(data);
//     }

//     // Do not delete local data based only on HTTP 200 and an
//     // unstructured or unrecognized response.
//     debugPrint(
//       'UNRECOGNIZED SERVER RESPONSE TYPE: ${data.runtimeType}',
//     );

//     return false;
//   }

//   // ---------------------------------------------------------------------------
//   // CHECK ONE SERVER RESPONSE OBJECT
//   // ---------------------------------------------------------------------------

//   bool _isSuccessfulResponseItem(dynamic item) {
//     if (item is! Map) {
//       return false;
//     }

//     // Normalize keys so both "StatusCode" and "statusCode" work.
//     final Map<String, dynamic> normalized =
//         <String, dynamic>{};

//     item.forEach((dynamic key, dynamic value) {
//       normalized[key.toString().toLowerCase()] = value;
//     });

//     // Some APIs wrap their result inside a "data" object or list.
//     final dynamic nestedData = normalized['data'];

//     if (nestedData is List) {
//       if (nestedData.isEmpty) {
//         return false;
//       }

//       return nestedData.every(
//         (dynamic nestedItem) =>
//             _isSuccessfulResponseItem(nestedItem),
//       );
//     }

//     if (nestedData is Map) {
//       return _isSuccessfulResponseItem(nestedData);
//     }

//     final dynamic rawStatusCode =
//         normalized['statuscode'] ?? normalized['status_code'];

//     final int? serverStatusCode =
//         int.tryParse(rawStatusCode?.toString() ?? '');

//     final String message =
//         (normalized['statusmessage'] ??
//                 normalized['message'] ??
//                 normalized['msg'] ??
//                 '')
//             .toString()
//             .trim()
//             .toLowerCase();

//     final dynamic rawSuccess = normalized['success'];

//     final bool explicitSuccess =
//         rawSuccess == true ||
//         rawSuccess?.toString().toLowerCase() == 'true';

//     final bool successMessage =
//         message.contains('inserted successfully') ||
//         message.contains('saved successfully') ||
//         message.contains('successfully inserted') ||
//         message == 'success';

//     final bool failureMessage =
//         message.contains('failed') ||
//         message.contains('failure') ||
//         message.contains('error') ||
//         message.contains('no records') ||
//         message.contains('not inserted');

//     // A success message with a failure indicator must never trigger deletion.
//     if (failureMessage) {
//       return false;
//     }

//     // Prefer the explicit server StatusCode + success message.
//     if ((serverStatusCode == 200 || serverStatusCode == 201) &&
//         successMessage) {
//       return true;
//     }

//     // Also allow APIs that explicitly return success=true.
//     if (explicitSuccess && failureMessage == false) {
//       return true;
//     }

//     // Support APIs that return a successful status and a success message.
//     final String status =
//         (normalized['status'] ?? '').toString().toLowerCase();

//     if ((status == 'success' || status == 'true') &&
//         failureMessage == false) {
//       return true;
//     }

//     debugPrint(
//       'RESPONSE NOT RECOGNIZED AS SUCCESS: $item',
//     );

//     return false;
//   }

//   // ---------------------------------------------------------------------------
//   // PREPARE PHOTO AS PNG
//   // ---------------------------------------------------------------------------

//   Future<File?> _preparePngFile(
//     String sourcePath,
//     String uniqueId,
//     String photoName,
//   ) async {
//     try {
//       final File sourceFile = File(sourcePath);

//       if (!await sourceFile.exists()) {
//         debugPrint(
//           '$photoName DOES NOT EXIST: $sourcePath',
//         );
//         return null;
//       }

//       final Directory outputDirectory = Directory(
//         path.join(
//           sourceFile.parent.path,
//           'sync_png',
//         ),
//       );

//       if (!await outputDirectory.exists()) {
//         await outputDirectory.create(recursive: true);
//       }

//       // Use a filesystem-safe name for the generated image.
//       final String safeUniqueId = uniqueId.replaceAll(
//         RegExp(r'[^a-zA-Z0-9_-]'),
//         '_',
//       );

//       final String outputPath = path.join(
//         outputDirectory.path,
//         '${safeUniqueId}_$photoName.png',
//       );

//       final XFile? result =
//           await FlutterImageCompress.compressAndGetFile(
//         sourceFile.path,
//         outputPath,
//         format: CompressFormat.png,
//       );

//       if (result == null) {
//         debugPrint(
//           '$photoName PNG CONVERSION FAILED.',
//         );
//         return null;
//       }

//       final File outputFile = File(result.path);

//       if (!await outputFile.exists()) {
//         debugPrint(
//           '$photoName PNG OUTPUT DOES NOT EXIST: ${result.path}',
//         );
//         return null;
//       }

//       debugPrint(
//         '$photoName PNG CREATED: ${result.path}',
//       );

//       return outputFile;
//     } catch (e, stackTrace) {
//       debugPrint('$photoName PNG PREPARATION ERROR: $e');
//       debugPrint('$stackTrace');
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
//     final dynamic value = data[key];

//     if (value == null) {
//       return '';
//     }

//     return value.toString();
//   }

//   // ---------------------------------------------------------------------------
//   // VALID PHOTO PATH
//   // ---------------------------------------------------------------------------

//   String? _validPath(String value) {
//     final String trimmed = value.trim();

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


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:package_info_plus/package_info_plus.dart';

import '../../database/database_helper.dart';
import '../../device_id_service.dart';
import '../data_view/data_view_controller.dart';

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
  // API
  // ---------------------------------------------------------------------------

  static const String syncUrl =
      'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

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

  Future<void> loadPendingData({bool force = false}) async {
    if (isSyncing.value && !force) {
      return;
    }

    try {
      isLoading.value = true;

      final data =
          await database.getPendingSurveys();

      pendingData.assignAll(
        data
            .map(
              (item) =>
                  Map<String, dynamic>.from(item),
            )
            .toList(),
      );

      totalCount.value =
          pendingData.length;

      statusMessage.value =
          pendingData.isEmpty
              ? 'No pending data available.'
              : '${pendingData.length} pending record(s) available.';

      debugPrint(
        'PENDING RECORD COUNT: ${pendingData.length}',
      );
    } catch (e) {
      debugPrint(
        'LOAD PENDING DATA ERROR: $e',
      );

      statusMessage.value =
          'Unable to load pending data.';

      Get.snackbar(
        'Error',
        'Unable to load pending data.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // START SYNC
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
        snackPosition:
            SnackPosition.BOTTOM,
      );
      return;
    }

    isSyncing.value = true;

    successCount.value = 0;
    failedCount.value = 0;

    statusMessage.value =
        'Getting application version...';

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final syncedVersion = packageInfo.version.trim();
      if (syncedVersion.isEmpty) {
        throw StateError('Installed application version is unavailable.');
      }

      debugPrint(
        'SYNC APP VERSION: $syncedVersion',
      );

      final records =
          List<Map<String, dynamic>>.from(
        pendingData,
      );

      for (int i = 0; i < records.length; i++) {
        final survey = records[i];

        final uniqueId =
            _value(survey, 'p1');

        currentUniqueId.value =
            uniqueId;

        statusMessage.value =
            'Syncing ${i + 1} of ${records.length}';

        debugPrint(
          'SYNCING RECORD ${i + 1}/${records.length}: $uniqueId',
        );

        final success =
            await _syncSingleSurvey(
          survey,
          syncedVersion,
        );

        if (success) {
          successCount.value++;
        } else {
          failedCount.value++;
        }
      }

      await loadPendingData(force: true);

      currentUniqueId.value = '';

      if (failedCount.value == 0) {
        statusMessage.value =
            'Synchronization completed successfully.';

        Get.snackbar(
          'Sync Completed',
          '${successCount.value} record(s) synchronized successfully.',
          snackPosition:
              SnackPosition.BOTTOM,
          duration:
              const Duration(seconds: 4),
        );
      } else {
        statusMessage.value =
            'Synchronization completed with some failures.';

        Get.snackbar(
          'Sync Completed',
          '${successCount.value} succeeded, '
              '${failedCount.value} failed.',
          snackPosition:
              SnackPosition.BOTTOM,
          duration:
              const Duration(seconds: 5),
        );
      }
    } catch (e) {
      debugPrint(
        'SYNC ALL ERROR: $e',
      );

      statusMessage.value =
          'Synchronization failed.';

      Get.snackbar(
        'Sync Error',
        'Unable to complete synchronization.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      currentUniqueId.value = '';
      isSyncing.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // SYNC SINGLE SURVEY
  // ---------------------------------------------------------------------------

  Future<bool> _syncSingleSurvey(
    Map<String, dynamic> survey,
    String syncedVersion,
  ) async {
    final String p1 = _value(survey, 'p1');

    try {
      if (p1.isEmpty) {
        throw StateError('Survey is missing its local unique ID (P1).');
      }

      // Backfill legacy local rows and save P16 BEFORE constructing the request.
      // The request payload is then built from the refreshed SQLite row, so the
      // exact values displayed locally are the values sent to the server.
      final String deviceId = await DeviceIdService.getOrCreateDeviceId();
      final String existingDeviceId = _value(survey, 'p13').trim();
      await database.updateSurvey(
        p1,
        {
          'p13': existingDeviceId.isNotEmpty ? existingDeviceId : deviceId,
          'p16': syncedVersion,
          'syncStatus': 'Pending',
        },
      );

      final Map<String, dynamic> localSurvey =
          await database.getSurveyById(p1) ?? survey;

      final String p2 = _value(localSurvey, 'p2');
      final String p3 = _value(localSurvey, 'p3');
      final String p4 = _value(localSurvey, 'p4');
      final String p5 = _value(localSurvey, 'p5');
      final String p6 = _value(localSurvey, 'p6');
      final String p7 = _value(localSurvey, 'p7');
      final String p8 = _value(localSurvey, 'p8');
      final String p9 = _value(localSurvey, 'p9');
      final String p10 = _value(localSurvey, 'p10');
      final String p11 = _value(localSurvey, 'p11');
      final String p12 = _value(localSurvey, 'p12');
      final String p13 = _value(localSurvey, 'p13');
      final String p14 = _value(localSurvey, 'p14');
      final String p15 = _value(localSurvey, 'p15');
      final String p16 = _value(localSurvey, 'p16');
      final String p17 = _value(localSurvey, 'p17');
      final String p100 = _value(localSurvey, 'p100');

      // Maintain the existing API parameter order exactly.
      final String values = [
        p1, p2, p3, p4, p5, p6, p7, p8, p9,
        p10, p11, p12, p13, p14, p15, p16, p17, p100,
      ].join(r'$|$');

      debugPrint('--------------------------------------------------');
      debugPrint('SYNC UNIQUE ID: $p1');
      debugPrint('SYNC PARAMETERS: $parameter');
      debugPrint('SYNC VALUES FROM SQLITE: $values');

      final formData = dio.FormData.fromMap({
        'applicantId': applicantId,
        'parameter': parameter,
        'values': values,
      });

      // Photo 1 is attached from the local file path stored in P8.
      final String? photo1Path = _validPath(p8);
      if (photo1Path != null) {
        final File? photo1File = await _preparePngFile(
          photo1Path, p1, 'photo1',
        );
        if (photo1File != null) {
          formData.files.add(MapEntry(
            'photo1',
            await dio.MultipartFile.fromFile(
              photo1File.path,
              filename: '${p1}_photo1.png',
            ),
          ));
        }
      }

      // Photo 2 is attached from the local file path stored in P9.
      final String? photo2Path = _validPath(p9);
      if (photo2Path != null) {
        final File? photo2File = await _preparePngFile(
          photo2Path, p1, 'photo2',
        );
        if (photo2File != null) {
          formData.files.add(MapEntry(
            'photo2',
            await dio.MultipartFile.fromFile(
              photo2File.path,
              filename: '${p1}_photo2.png',
            ),
          ));
        }
      }

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

      if (_isSuccessfulResponse(response)) {
        // IMPORTANT: delete only after the server confirms success.
        await database.deleteSurvey(p1);

        // Refresh Data View immediately if its controller is still alive.
        if (Get.isRegistered<DataViewController>()) {
          await Get.find<DataViewController>().loadData();
        }

        debugPrint('SYNC SUCCESS; LOCAL RECORD DELETED: $p1');
        return true;
      }

      // Keep the complete local record for retry after an unsuccessful response.
      await database.updateSyncStatus(p1, 'Pending');
      debugPrint('SYNC FAILED; LOCAL RECORD RETAINED: $p1');
      return false;
    } on dio.DioException catch (e) {
      debugPrint('DIO SYNC ERROR [$p1]: ${e.message}');
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('RESPONSE: ${e.response?.data}');
      await database.updateSyncStatus(p1, 'Pending');
      return false;
    } catch (e) {
      debugPrint('SYNC ERROR [$p1]: $e');
      await database.updateSyncStatus(p1, 'Pending');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // SUCCESS RESPONSE CHECK
  // ---------------------------------------------------------------------------

  bool _isSuccessfulResponse(
    dio.Response response,
  ) {
    final httpStatus = response.statusCode;

    if (httpStatus != 200 && httpStatus != 201) {
      debugPrint('SYNC FAILED: HTTP status $httpStatus');
      return false;
    }

    dynamic data = response.data;

    // Some server configurations return JSON as a string instead of decoding it.
    if (data is String) {
      final body = data.trim();
      if (body.isEmpty) {
        debugPrint('SYNC FAILED: Empty response body');
        return false;
      }

      try {
        data = jsonDecode(body);
      } catch (_) {
        final lowerBody = body.toLowerCase();
        final plainTextSuccess =
            lowerBody.contains('inserted successfully') ||
            lowerBody.contains('saved successfully');
        debugPrint('SYNC RESPONSE TEXT: $body');
        return plainTextSuccess;
      }
    }

    debugPrint('SYNC RESPONSE TYPE: ${data.runtimeType}');

    // Actual API response observed in the device logs:
    // [{StatusCode: 200, StatusMessage: Inserted Successfully ( Ack - 10 )}]
    if (data is List) {
      if (data.isEmpty) {
        debugPrint('SYNC FAILED: Empty response list');
        return false;
      }

      for (final item in data) {
        if (item is! Map) {
          continue;
        }

        final rawCode = item['StatusCode'] ??
            item['statusCode'] ??
            item['status_code'];
        final code = int.tryParse(rawCode?.toString() ?? '');

        final rawMessage = item['StatusMessage'] ??
            item['statusMessage'] ??
            item['message'] ??
            item['Message'];
        final message = (rawMessage ?? '').toString().trim().toLowerCase();

        debugPrint('API STATUS CODE: $code');
        debugPrint('API STATUS MESSAGE: $message');

        final successfulCode = code == 200 || code == 201;
        final successfulMessage =
            message.contains('inserted successfully') ||
            message.contains('saved successfully') ||
            message == 'success' ||
            message == 'successful';

        if (successfulCode && successfulMessage) {
          debugPrint('SYNC RESPONSE ACCEPTED');
          return true;
        }
      }

      debugPrint('SYNC FAILED: No successful status entry in response list');
      return false;
    }

    // Also support an API response that returns a single object.
    if (data is Map) {
      final rawCode = data['StatusCode'] ??
          data['statusCode'] ??
          data['status_code'];
      final code = int.tryParse(rawCode?.toString() ?? '');

      final rawMessage = data['StatusMessage'] ??
          data['statusMessage'] ??
          data['message'] ??
          data['Message'];
      final message = (rawMessage ?? '').toString().trim().toLowerCase();

      final successFlag = data['success'] ?? data['Success'];
      final successfulFlag = successFlag == true ||
          successFlag?.toString().toLowerCase() == 'true';
      final successfulCode = code == 200 || code == 201;
      final successfulMessage =
          message.contains('inserted successfully') ||
          message.contains('saved successfully') ||
          message == 'success' ||
          message == 'successful';

      if (successfulFlag || (successfulCode && successfulMessage)) {
        debugPrint('SYNC RESPONSE ACCEPTED');
        return true;
      }

      debugPrint(
        'SYNC FAILED: Unrecognized map response; '
        'code=$code, message=$message',
      );
      return false;
    }

    debugPrint('SYNC FAILED: Unrecognized response format');
    return false;
  }

  // ---------------------------------------------------------------------------
  // PREPARE PHOTO AS PNG
  // ---------------------------------------------------------------------------

  Future<File?>
      _preparePngFile(
    String sourcePath,
    String uniqueId,
    String photoName,
  ) async {
    try {
      final sourceFile =
          File(sourcePath);

      if (!await sourceFile.exists()) {
        debugPrint(
          '$photoName does not exist: $sourcePath',
        );

        return null;
      }

      final outputDirectory =
          Directory(
        path.join(
          sourceFile.parent.path,
          'sync_png',
        ),
      );

      if (!await outputDirectory
          .exists()) {
        await outputDirectory.create(
          recursive: true,
        );
      }

      final outputPath =
          path.join(
        outputDirectory.path,
        '${uniqueId}_$photoName.png',
      );

      final result =
          await FlutterImageCompress
              .compressAndGetFile(
        sourceFile.path,
        outputPath,
        format:
            CompressFormat.png,
      );

      if (result == null) {
        debugPrint(
          '$photoName PNG conversion failed.',
        );

        return null;
      }

      debugPrint(
        '$photoName PNG CREATED: ${result.path}',
      );

      return File(
        result.path,
      );
    } catch (e) {
      debugPrint(
        '$photoName PNG PREPARATION ERROR: $e',
      );

      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // VALUE HELPER
  // ---------------------------------------------------------------------------

  String _value(
    Map<String, dynamic> data,
    String key,
  ) {
    final value =
        data[key];

    if (value == null) {
      return '';
    }

    return value.toString();
  }

  // ---------------------------------------------------------------------------
  // VALID PHOTO PATH
  // ---------------------------------------------------------------------------

  String? _validPath(
    String value,
  ) {
    final trimmed =
        value.trim();

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
