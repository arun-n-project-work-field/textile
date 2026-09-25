import 'package:get/get.dart';

import '../../database/database_helper.dart';

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
    try {
      await database.deleteSurvey(uniqueId);

      dataList.removeWhere(
        (data) => data['p1']?.toString() == uniqueId,
      );

      Get.snackbar(
        'Deleted',
        'Data deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('DATA VIEW DELETE ERROR: $e');

      Get.snackbar(
        'Error',
        'Unable to delete data.',
        snackPosition: SnackPosition.BOTTOM,
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