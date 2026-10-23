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

  static const String applicantId = '1_Insert_Handloom_Data_Trans';

  static const String parameter =
      r'P1$|$P2$|$P3$|$P4$|$P5$|$P6$|$P7$|$P8$|$P9$|$P10$|$P11$|$P12$|$P13$|$P14$|$P15$|$P16$|$P17$|$P100';

  // ---------------------------------------------------------------------------
  // OBSERVABLES
  // ---------------------------------------------------------------------------

  final RxList<Map<String, dynamic>> pendingData = <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isSyncing = false.obs;

  final RxInt totalCount = 0.obs;
  final RxInt successCount = 0.obs;
  final RxInt failedCount = 0.obs;

  final RxString currentUniqueId = ''.obs;

  final RxString statusMessage = 'Loading pending data...'.obs;

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

      final data = await database.getPendingSurveys();

      pendingData.assignAll(
        data.map((item) => Map<String, dynamic>.from(item)).toList(),
      );

      totalCount.value = pendingData.length;

      statusMessage.value = pendingData.isEmpty
          ? 'No pending data available.'
          : '${pendingData.length} pending record(s) available.';

      debugPrint('PENDING RECORD COUNT: ${pendingData.length}');
    } catch (e) {
      debugPrint('LOAD PENDING DATA ERROR: $e');

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
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSyncing.value = true;

    successCount.value = 0;
    failedCount.value = 0;

    statusMessage.value = 'Getting application version...';

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final syncedVersion = packageInfo.version.trim();
      if (syncedVersion.isEmpty) {
        throw StateError('Installed application version is unavailable.');
      }

      debugPrint('SYNC APP VERSION: $syncedVersion');

      final records = List<Map<String, dynamic>>.from(pendingData);

      for (int i = 0; i < records.length; i++) {
        final survey = records[i];

        final uniqueId = _value(survey, 'p1');

        currentUniqueId.value = uniqueId;

        statusMessage.value = 'Syncing ${i + 1} of ${records.length}';

        debugPrint('SYNCING RECORD ${i + 1}/${records.length}: $uniqueId');

        final success = await _syncSingleSurvey(survey, syncedVersion);

        if (success) {
          successCount.value++;
        } else {
          failedCount.value++;
        }
      }

      await loadPendingData(force: true);

      currentUniqueId.value = '';

      if (failedCount.value == 0) {
        statusMessage.value = 'Synchronization completed successfully.';

        Get.snackbar(
          'Sync Completed',
          '${successCount.value} record(s) synchronized successfully.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
        );
      } else {
        statusMessage.value = 'Synchronization completed with some failures.';

        Get.snackbar(
          'Sync Completed',
          '${successCount.value} succeeded, '
              '${failedCount.value} failed.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      debugPrint('SYNC ALL ERROR: $e');

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
      await database.updateSurvey(p1, {
        'p13': existingDeviceId.isNotEmpty ? existingDeviceId : deviceId,
        'p16': syncedVersion,
        'syncStatus': 'Pending',
      });

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
        }
      }

      // Photo 2 is attached from the local file path stored in P9.
      final String? photo2Path = _validPath(p9);
      if (photo2Path != null) {
        final File? photo2File = await _preparePngFile(
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

  bool _isSuccessfulResponse(dio.Response response) {
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

        final rawCode =
            item['StatusCode'] ?? item['statusCode'] ?? item['status_code'];
        final code = int.tryParse(rawCode?.toString() ?? '');

        final rawMessage =
            item['StatusMessage'] ??
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
      final rawCode =
          data['StatusCode'] ?? data['statusCode'] ?? data['status_code'];
      final code = int.tryParse(rawCode?.toString() ?? '');

      final rawMessage =
          data['StatusMessage'] ??
          data['statusMessage'] ??
          data['message'] ??
          data['Message'];
      final message = (rawMessage ?? '').toString().trim().toLowerCase();

      final successFlag = data['success'] ?? data['Success'];
      final successfulFlag =
          successFlag == true ||
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

  Future<File?> _preparePngFile(
    String sourcePath,
    String uniqueId,
    String photoName,
  ) async {
    try {
      final sourceFile = File(sourcePath);

      if (!await sourceFile.exists()) {
        debugPrint('$photoName does not exist: $sourcePath');

        return null;
      }

      final outputDirectory = Directory(
        path.join(sourceFile.parent.path, 'sync_png'),
      );

      if (!await outputDirectory.exists()) {
        await outputDirectory.create(recursive: true);
      }

      final outputPath = path.join(
        outputDirectory.path,
        '${uniqueId}_$photoName.png',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        sourceFile.path,
        outputPath,
        format: CompressFormat.png,
      );

      if (result == null) {
        debugPrint('$photoName PNG conversion failed.');

        return null;
      }

      debugPrint('$photoName PNG CREATED: ${result.path}');

      return File(result.path);
    } catch (e) {
      debugPrint('$photoName PNG PREPARATION ERROR: $e');

      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // VALUE HELPER
  // ---------------------------------------------------------------------------

  String _value(Map<String, dynamic> data, String key) {
    final value = data[key];

    if (value == null) {
      return '';
    }

    return value.toString();
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
