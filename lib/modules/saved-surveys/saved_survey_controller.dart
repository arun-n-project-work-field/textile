import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/database_helper.dart';

class SavedSurveyController extends GetxController {
  // ==========================================================
  // DATABASE
  // ==========================================================

  final DatabaseHelper database =
      DatabaseHelper.instance;

  // ==========================================================
  // DATA
  // ==========================================================

  final RxList<Map<String, dynamic>> surveys =
      <Map<String, dynamic>>[].obs;

  // ==========================================================
  // LOADING
  // ==========================================================

  final RxBool isLoading = false.obs;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    loadSurveys();
  }

  // ==========================================================
  // READY
  // ==========================================================

  @override
  void onReady() {
    super.onReady();

    loadSurveys();
  }

  // ==========================================================
  // LOAD ALL SURVEYS
  // ==========================================================

  Future<void> loadSurveys() async {
    try {
      isLoading.value = true;

      final List<Map<String, dynamic>>
          result =
          await database.getAllSurveys();

      surveys.assignAll(result);

      debugPrint(
        'SAVED SURVEYS LOADED: ${surveys.length}',
      );
    } catch (e) {
      debugPrint(
        'LOAD SAVED SURVEYS ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Unable to load saved data.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // REFRESH
  // ==========================================================

  Future<void> refreshData() async {
    await loadSurveys();
  }

  // ==========================================================
  // DELETE SURVEY
  // ==========================================================

  Future<void> deleteSurvey(
    String id,
  ) async {
    try {
      await database.deleteSurvey(id);

      await loadSurveys();

      Get.snackbar(
        'Deleted',
        'Saved data deleted successfully.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(
        'DELETE SURVEY ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Unable to delete saved data.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    }
  }

  // ==========================================================
  // DELETE WITH CONFIRMATION
  // ==========================================================

  Future<void> confirmDelete(
    Map<String, dynamic> survey,
  ) async {
    final String uniqueId =
        survey['p1']?.toString() ?? '';

    final bool? confirmed =
        await Get.dialog<bool>(
      AlertDialog(
        title:
            const Text(
          'Delete Data?',
        ),
        content:
            const Text(
          'Are you sure you want to delete this saved geo-tagged data?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(
                result: false,
              );
            },
            child:
                const Text(
              'Cancel',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(
                result: true,
              );
            },
            child:
                const Text(
              'Delete',
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (confirmed == true &&
        uniqueId.isNotEmpty) {
      await deleteSurvey(uniqueId);
    }
  }

  // ==========================================================
  // COUNT
  // ==========================================================

  int get totalCount =>
      surveys.length;

  // ==========================================================
  // PENDING COUNT
  // ==========================================================

  int get pendingCount {
    return surveys.where((survey) {
      final String status =
          survey['syncStatus']
                  ?.toString()
                  .toLowerCase() ??
              '';

      return status == 'pending';
    }).length;
  }

  // ==========================================================
  // SYNCED COUNT
  // ==========================================================

  int get syncedCount {
    return surveys.where((survey) {
      final String status =
          survey['syncStatus']
                  ?.toString()
                  .toLowerCase() ??
              '';

      return status == 'synced';
    }).length;
  }
}