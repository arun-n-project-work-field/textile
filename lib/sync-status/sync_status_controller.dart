import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SurveySyncModel {
  final String barcode;
  final String latitude;
  final String longitude;
  final int productCount;
  bool synced;

  SurveySyncModel({
    required this.barcode,
    required this.latitude,
    required this.longitude,
    required this.productCount,
    this.synced = false,
  });
}

class SyncStatusController extends GetxController {

  //--------------------------------------------
  // SURVEY LIST
  //--------------------------------------------

  RxList<SurveySyncModel> surveys =
      <SurveySyncModel>[].obs;

  //--------------------------------------------
  // LOADING
  //--------------------------------------------

  RxBool isUploading = false.obs;

  //--------------------------------------------
  // INIT
  //--------------------------------------------

  @override
  void onInit() {
    super.onInit();

    loadLocalSurveys();
  }

  //--------------------------------------------
  // LOAD LOCAL SURVEYS
  //--------------------------------------------

  void loadLocalSurveys() {

    // TODO:
    // Replace with SQLite query

    surveys.assignAll([

      SurveySyncModel(
        barcode: "HL000001",
        latitude: "13.028900",
        longitude: "77.589400",
        productCount: 3,
      ),

      SurveySyncModel(
        barcode: "HL000002",
        latitude: "13.028910",
        longitude: "77.589500",
        productCount: 2,
      ),

      SurveySyncModel(
        barcode: "HL000003",
        latitude: "13.028930",
        longitude: "77.589600",
        productCount: 5,
      ),
    ]);
  }

  //--------------------------------------------
  // DELETE SURVEY
  //--------------------------------------------

  void deleteSurvey(int index) {

    surveys.removeAt(index);

    Get.snackbar(
      "Deleted",
      "Survey removed successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
    //--------------------------------------------
  // SYNC SINGLE SURVEY
  //--------------------------------------------

  Future<void> syncSurvey(int index) async {

    if (surveys[index].synced) {
      return;
    }

    isUploading.value = true;

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {

      // TODO:
      // Read survey from SQLite

      // TODO:
      // Upload GeoTag Data

      // TODO:
      // Upload Product List

      // TODO:
      // Upload Images

      await Future.delayed(
        const Duration(seconds: 2),
      );

      surveys[index].synced = true;

      surveys.refresh();

      Get.back();

      Get.snackbar(
        "Success",
        "Survey uploaded successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.snackbar(
        "Upload Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      isUploading.value = false;

    }
  }

  //--------------------------------------------
  // SYNC ALL
  //--------------------------------------------

  Future<void> syncAll() async {

    if (surveys.isEmpty) {

      Get.snackbar(
        "No Data",
        "No surveys available.",
      );

      return;
    }

    isUploading.value = true;

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {

      for (int i = 0; i < surveys.length; i++) {

        if (!surveys[i].synced) {

          // TODO:
          // Upload current survey

          await Future.delayed(
            const Duration(milliseconds: 800),
          );

          surveys[i].synced = true;
        }
      }

      surveys.refresh();

      Get.back();

      Get.snackbar(
        "Completed",
        "All pending surveys uploaded successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.snackbar(
        "Sync Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      isUploading.value = false;

    }
  }

  //--------------------------------------------
  // REFRESH DATA
  //--------------------------------------------

  Future<void> refreshData() async {

    loadLocalSurveys();

  }

  //--------------------------------------------
  // TOTAL SURVEYS
  //--------------------------------------------

  int get totalSurveys => surveys.length;

  //--------------------------------------------
  // TOTAL PENDING
  //--------------------------------------------

  int get pendingSurveys =>
      surveys.where((e) => !e.synced).length;

  //--------------------------------------------
  // TOTAL SYNCED
  //--------------------------------------------

  int get syncedSurveys =>
      surveys.where((e) => e.synced).length;

}