import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../database/database_helper.dart';
import '../../device_id_service.dart';

class DataViewController extends GetxController {
  final DatabaseHelper database = DatabaseHelper.instance;

  final dataList = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  // ==========================================================
  // LOAD DATA
  // ==========================================================

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      // Repair older local rows that were saved before P13/P16 were populated.
      final deviceId = await DeviceIdService.getOrCreateDeviceId();
      final packageInfo = await PackageInfo.fromPlatform();
      final installedVersion = packageInfo.version.trim();

      final existingRows = await database.getAllSurveys();
      for (final row in existingRows) {
        final id = row['p1']?.toString() ?? '';
        if (id.isEmpty) continue;

        final updates = <String, dynamic>{};
        final p13 = row['p13']?.toString().trim() ?? '';
        final p16 = row['p16']?.toString().trim() ?? '';

        if (p13.isEmpty) updates['p13'] = deviceId;
        // P16 is the app version used for synchronization. Populate legacy rows
        // now, and Sync Data refreshes it again immediately before upload.
        if (p16.isEmpty && installedVersion.isNotEmpty) {
          updates['p16'] = installedVersion;
        }

        if (updates.isNotEmpty) {
          await database.updateSurvey(id, updates);
        }
      }

      final data = await database.getAllSurveys();
      dataList.assignAll(data);
    } catch (e) {
      print('DATA VIEW LOAD ERROR: $e');

      Get.snackbar(
        'Error',
        'Unable to load data.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // REFRESH
  // ==========================================================

  Future<void> refreshData() async {
    await loadData();
  }

  // ==========================================================
  // DELETE DATA
  // ==========================================================

  Future<void> deleteData(String uniqueId) async {
    final id = uniqueId.trim();

    if (id.isEmpty) {
      Get.snackbar(
        'Delete failed',
        'This record has no P1/Unique ID, so it cannot be deleted.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final deletedRows = await database.deleteSurvey(id);
      await loadData();

      if (deletedRows == 0) {
        debugPrint('DATA VIEW DELETE: no row matched P1="$id"');
        Get.snackbar(
          'Record not found',
          'No local record matched this ID. Refresh the screen and try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      Get.snackbar(
        'Deleted',
        'Data deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      debugPrint('DATA VIEW DELETE ERROR for P1="$id": $e');
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar(
        'Delete failed',
        'Unable to delete data: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
      );
    }
  }

  // ==========================================================
  // COUNTS
  // ==========================================================

  int get totalCount {
    return dataList.length;
  }

  int get pendingCount {
    return dataList.where((data) {
      final status = data['syncStatus']?.toString().toLowerCase();

      return status != 'synced';
    }).length;
  }

  int get syncedCount {
    return dataList.where((data) {
      final status = data['syncStatus']?.toString().toLowerCase();

      return status == 'synced';
    }).length;
  }
}
