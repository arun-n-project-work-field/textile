import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDetailsController extends GetxController {

  //------------------------------------------
  // TEXT CONTROLLERS
  //------------------------------------------

  final productNameController = TextEditingController();
  final colourController = TextEditingController();
  final patternController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final weightController = TextEditingController();
  final productionDateController = TextEditingController();

  final productIdController = TextEditingController();
  final batchController = TextEditingController();
  final remarksController = TextEditingController();

  final barcodeController = TextEditingController();

  //------------------------------------------
  // DROPDOWNS
  //------------------------------------------

  final categories = [
    "Saree",
    "Shawl",
    "Bedsheet",
    "Towel",
    "Dress Material",
    "Dupatta",
    "Lungi",
    "Other",
  ];

  final fabricTypes = [
    "Cotton",
    "Silk",
    "Linen",
    "Wool",
    "Khadi",
    "Blended",
  ];

  final weavingTechniques = [
    "Handwoven",
    "Jacquard",
    "Plain Weave",
    "Twill",
    "Dobby",
    "Other",
  ];

  RxString selectedCategory = "Saree".obs;
  RxString selectedFabric = "Cotton".obs;
  RxString selectedTechnique = "Handwoven".obs;

  //------------------------------------------
  // IMAGES
  //------------------------------------------

  RxString frontImage = "".obs;
  RxString backImage = "".obs;
  RxString closeupImage = "".obs;

  //------------------------------------------
  // BARCODE
  //------------------------------------------

  RxBool barcodeGenerated = false.obs;

  @override
  void onInit() {
    super.onInit();

    generateProductId();
  }

  @override
  void onClose() {
    productNameController.dispose();
    colourController.dispose();
    patternController.dispose();
    lengthController.dispose();
    widthController.dispose();
    weightController.dispose();
    productionDateController.dispose();
    productIdController.dispose();
    batchController.dispose();
    remarksController.dispose();
    barcodeController.dispose();

    super.onClose();
  }

  //------------------------------------------
  // PRODUCT ID
  //------------------------------------------

  void generateProductId() {
    final id =
        "HL${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}";

    productIdController.text = id;
  }

  //------------------------------------------
  // DATE
  //------------------------------------------

  Future<void> pickProductionDate() async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      productionDateController.text =
          DateFormat("dd-MM-yyyy").format(date);
    }
  }

  //------------------------------------------
  // IMAGES
  //------------------------------------------

  Future<void> captureFrontImage() async {
    // TODO:
    // ImagePicker

    frontImage.value = "front.jpg";

    Get.snackbar(
      "Success",
      "Front Image Captured",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> captureBackImage() async {
    // TODO:
    // ImagePicker

    backImage.value = "back.jpg";

    Get.snackbar(
      "Success",
      "Back Image Captured",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> captureCloseupImage() async {
    // TODO:
    // ImagePicker

    closeupImage.value = "closeup.jpg";

    Get.snackbar(
      "Success",
      "Close-up Image Captured",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //------------------------------------------
  // BARCODE
  //------------------------------------------

  void generateBarcode() {

    barcodeController.text = productIdController.text;

    barcodeGenerated.value = true;

    Get.snackbar(
      "Success",
      "Barcode Generated Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //------------------------------------------
  // SAVE DRAFT
  //------------------------------------------

  Future<void> saveDraft() async {

    // TODO
    // Save to SQLite

    Get.snackbar(
      "Saved",
      "Draft Saved Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //------------------------------------------
  // PREVIEW
  //------------------------------------------

  void previewProduct() {

    Get.snackbar(
      "Preview",
      "Opening Preview Screen",
      snackPosition: SnackPosition.BOTTOM,
    );

    // TODO

    // Get.toNamed(AppRoutes.preview);
  }

  //------------------------------------------
  // SAVE & CONTINUE
  //------------------------------------------

  Future<void> saveAndContinue() async {

    if (productNameController.text.isEmpty) {
      Get.snackbar("Validation", "Enter Product Name");
      return;
    }

    if (colourController.text.isEmpty) {
      Get.snackbar("Validation", "Enter Colour");
      return;
    }

    if (weightController.text.isEmpty) {
      Get.snackbar("Validation", "Enter Weight");
      return;
    }

    if (frontImage.value.isEmpty) {
      Get.snackbar("Validation", "Capture Front Image");
      return;
    }

    if (!barcodeGenerated.value) {
      Get.snackbar("Validation", "Generate Barcode");
      return;
    }

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    Get.back();

    Get.snackbar(
      "Success",
      "Product Saved Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );

    // TODO

    // Navigate to Preview

    // Get.toNamed(AppRoutes.preview);
  }
}