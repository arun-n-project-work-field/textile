import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_compress/image_compress.dart';
import 'package:path/path.dart' as path;

import '../../core/database/database_helper.dart';

class SyncDataController extends GetxController {
  final DatabaseHelper database = DatabaseHelper.instance;

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 180),
    ),
  );

  static const String syncUrl =
      'https://maps.ksrsac.in/Generic_Image_Mis_Insert';

  static const String versionUrl =
      'https://kgis.ksrsac.in/api/app/version';

  static const String applicantId =
      '1_Insert_Handloom_Data_Trans';

  static const String parameter =
      'P1\$|\$P2\$|\$P3\$|\$P4\$|\$P5\$|\$P6\$|\$P7\$|\$P8\$|\$P9\$|\$P10\$|\$P11\$|\$P12\$|\$P13\$|\$P14\$|\$P15\$|\$P16\$|\$P17\$|\$P100';

  final RxList<Map<String, dynamic>> pendingData =
      <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isSyncing = false.obs;

  final RxInt totalCount = 0.obs;
  final RxInt successCount = 0.obs;
  final RxInt failedCount = 0.obs;

  final RxString currentUniqueId = ''.obs;
  final RxString statusMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPendingData();
  }

  // ---------------------------------------------------------------------------
  // LOAD PENDING DATA
  // ---------------------------------------------------------------------------

  Future<void> loadPendingData() async {
    try {
      isLoading.value = true;

      final data = await database.getPendingSurveys();

      pendingData.assignAll(
        data.map((e) => Map<String, dynamic>.from(e)).toList(),
      );

      totalCount.value = pendingData.length;
    } catch (e) {
      debugPrint('LOAD PENDING DATA ERROR: $e');

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
  // SYNC ALL DATA
  // ---------------------------------------------------------------------------

  Future<void> syncAllData() async {
    if (isSyncing.value) {
      return;
    }

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

    statusMessage.value = 'Starting synchronization...';

    try {
      final syncedVersion = await _getLatestAppVersion();

      debugPrint('SYNC VERSION: $syncedVersion');

      for (final survey in List<Map<String, dynamic>>.from(pendingData)) {
        final uniqueId = survey['p1']?.toString() ?? '';

        currentUniqueId.value = uniqueId;

        statusMessage.value =
            'Syncing ${successCount.value + failedCount.value + 1}'
            ' of ${pendingData.length}';

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

      await loadPendingData();

      statusMessage.value = 'Synchronization completed.';

      if (failedCount.value == 0) {
        Get.snackbar(
          'Sync Completed',
          '${successCount.value} record(s) synchronized successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Sync Completed',
          '${successCount.value} succeeded, '
          '${failedCount.value} failed.',
          snackPosition: SnackPosition.BOTTOM,
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
  // SYNC SINGLE RECORD
  // ---------------------------------------------------------------------------

  Future<bool> _syncSingleSurvey(
    Map<String, dynamic> survey,
    String syncedVersion,
  ) async {
    try {
      final p1 = _value(survey, 'p1');
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

      // P16 is sent as the current application version during sync.
      final p16 = syncedVersion;

      final p17 = _value(survey, 'p17');
      final p100 = _value(survey, 'p100');

      final values = [
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
      ].join('\$|\$');

      debugPrint('--------------------------------------------------');
      debugPrint('SYNC UNIQUE ID: $p1');
      debugPrint('SYNC APPLICANT ID: $applicantId');
      debugPrint('SYNC PARAMETERS: $parameter');
      debugPrint('SYNC VALUES: $values');

      final formData = FormData();

      formData.fields.add(
        MapEntry('applicantId', applicantId),
      );

      formData.fields.add(
        MapEntry('parameter', parameter),
      );

      formData.fields.add(
        MapEntry('values', values),
      );

      // -----------------------------------------------------------------------
      // PHOTO 1
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
              await MultipartFile.fromFile(
                photo1File.path,
                filename: '${p1}_photo1.png',
              ),
            ),
          );
        }
      }

      // -----------------------------------------------------------------------
      // PHOTO 2
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
              await MultipartFile.fromFile(
                photo2File.path,
                filename: '${p1}_photo2.png',
              ),
            ),
          );
        }
      }

      final response = await _dio.post(
        syncUrl,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          responseType: ResponseType.json,
        ),
      );

      debugPrint('SYNC HTTP STATUS: ${response.statusCode}');
      debugPrint('SYNC RESPONSE: ${response.data}');

      if (_isSuccessfulResponse(response)) {
        await database.updateSyncedVersion(
          p1,
          syncedVersion,
        );

        await database.updateSyncStatus(
          p1,
          'Synced',
        );

        return true;
      }

      await database.updateSyncStatus(
        p1,
        'Pending',
      );

      return false;
    } catch (e) {
      debugPrint(
        'SYNC ERROR [$p1]: $e',
      );

      await database.updateSyncStatus(
        p1,
        'Pending',
      );

      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // API SUCCESS CHECK
  // ---------------------------------------------------------------------------

  bool _isSuccessfulResponse(Response response) {
    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      return false;
    }

    final data = response.data;

    if (data is Map<String, dynamic>) {
      if (data['success'] == true) {
        return true;
      }

      final statusCode = data['statusCode'];

      if (statusCode == 200 ||
          statusCode == '200' ||
          statusCode == 201 ||
          statusCode == '201') {
        return true;
      }

      final status = data['status']?.toString().toLowerCase();

      if (status == 'success' ||
          status == 'true') {
        return true;
      }
    }

    // Some legacy APIs return HTTP 200 with a non-standard response.
    if (response.statusCode == 200) {
      if (data is String) {
        final text = data.toLowerCase();

        if (text.contains('success') ||
            text.contains('inserted') ||
            text.contains('saved')) {
          return true;
        }
      }
    }

    return false;
  }

  // ---------------------------------------------------------------------------
  // GET CURRENT APP VERSION
  // ---------------------------------------------------------------------------

  Future<String> _getLatestAppVersion() async {
    try {
      final response = await _dio.get(
        versionUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      debugPrint(
        'VERSION API RESPONSE: ${response.data}',
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        final nestedData = data['data'];

        if (nestedData is Map<String, dynamic>) {
          final version =
              nestedData['appVersion']?.toString();

          if (version != null && version.isNotEmpty) {
            return version;
          }
        }

        final version =
            data['appVersion']?.toString();

        if (version != null && version.isNotEmpty) {
          return version;
        }
      }
    } catch (e) {
      debugPrint(
        'GET VERSION FOR SYNC ERROR: $e',
      );
    }

    // If version API is unavailable, keep P16 empty rather than
    // inventing a version.
    return '';
  }

  // ---------------------------------------------------------------------------
  // PNG PREPARATION
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
          '$photoName does not exist: $sourcePath',
        );
        return null;
      }

      final outputDirectory =
          Directory('${sourceFile.parent.path}/sync_png');

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
        debugPrint(
          '$photoName PNG conversion failed.',
        );
        return null;
      }

      return File(result.path);
    } catch (e) {
      debugPrint(
        '$photoName PNG preparation error: $e',
      );
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------

  String _value(
    Map<String, dynamic> data,
    String key,
  ) {
    return data[key]?.toString() ?? '';
  }

  String? _validPath(String value) {
    if (value.trim().isEmpty) {
      return null;
    }

    return value;
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