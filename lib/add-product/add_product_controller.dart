// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddProductController extends GetxController {

//   //-------------------------------------------------
//   // TEXT CONTROLLERS
//   //-------------------------------------------------

//   final productNameController = TextEditingController();

//   final materialController = TextEditingController();

//   final colorController = TextEditingController();

//   final weightController = TextEditingController();

//   final priceController = TextEditingController();

//   final quantityController = TextEditingController();

//   final sizeController = TextEditingController();

//   final descriptionController = TextEditingController();

//   //-------------------------------------------------
//   // CATEGORY
//   //-------------------------------------------------

//   final categories = <String>[
//     "Saree",
//     "Shawl",
//     "Dress Material",
//     "Bedsheet",
//     "Towel",
//     "Lungi",
//     "Dupatta",
//     "Kurta",
//     "Scarf",
//     "Other",
//   ];

//   RxString selectedCategory = "Saree".obs;

//   void changeCategory(String? value) {
//     if (value != null) {
//       selectedCategory.value = value;
//     }
//   }

//   //-------------------------------------------------
//   // IMAGE
//   //-------------------------------------------------

//   RxString imagePath = "".obs;

//   //-------------------------------------------------
//   // BARCODE
//   //-------------------------------------------------

//   RxString barcode = "".obs;

//   @override
//   void onInit() {
//     super.onInit();

//     generateBarcode();
//   }

//   @override
//   void onClose() {

//     productNameController.dispose();
//     materialController.dispose();
//     colorController.dispose();
//     weightController.dispose();
//     priceController.dispose();
//     quantityController.dispose();
//     sizeController.dispose();
//     descriptionController.dispose();

//     super.onClose();
//   }
//     //-------------------------------------------------
//   // CAPTURE PRODUCT IMAGE
//   //-------------------------------------------------

//   Future<void> captureImage() async {
//     // TODO:
//     // Replace this with ImagePicker later.

//     imagePath.value = "assets/images/sample_product.jpg";

//     Get.snackbar(
//       "Image",
//       "Product image captured successfully",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   //-------------------------------------------------
//   // GENERATE BARCODE
//   //-------------------------------------------------

//   void generateBarcode() {
//     final random = Random();

//     final number = 100000 + random.nextInt(900000);

//     barcode.value = "HL-PRD-$number";
//   }

//   //-------------------------------------------------
//   // VALIDATION
//   //-------------------------------------------------

//   bool validate() {

//     if (productNameController.text.trim().isEmpty) {

//       Get.snackbar(
//         "Validation",
//         "Please enter Product Name",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (materialController.text.trim().isEmpty) {

//       Get.snackbar(
//         "Validation",
//         "Please enter Material",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (weightController.text.trim().isEmpty) {

//       Get.snackbar(
//         "Validation",
//         "Please enter Weight",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (priceController.text.trim().isEmpty) {

//       Get.snackbar(
//         "Validation",
//         "Please enter Selling Price",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (quantityController.text.trim().isEmpty) {

//       Get.snackbar(
//         "Validation",
//         "Please enter Quantity",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     return true;
//   }

//   //-------------------------------------------------
//   // SAVE PRODUCT
//   //-------------------------------------------------

//   Future<void> saveProduct() async {

//     if (!validate()) return;

//     // TODO
//     // Save to SQLite

//     Get.snackbar(
//       "Success",
//       "Product saved successfully",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   //-------------------------------------------------
//   // SAVE & ADD ANOTHER
//   //-------------------------------------------------

//   Future<void> saveAndAddAnother() async {

//     if (!validate()) return;

//     // TODO
//     // Save to SQLite

//     Get.snackbar(
//       "Saved",
//       "Product saved. Add another product.",
//       snackPosition: SnackPosition.BOTTOM,
//     );

//     clearForm();

//     generateBarcode();
//   }
//     //-------------------------------------------------
//   // FINISH
//   //-------------------------------------------------

//   void finish() {

//     Get.back();

//     Get.snackbar(
//       "Completed",
//       "All products have been added successfully.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   //-------------------------------------------------
//   // CLEAR FORM
//   //-------------------------------------------------

//   void clearForm() {

//     productNameController.clear();

//     materialController.clear();

//     colorController.clear();

//     weightController.clear();

//     priceController.clear();

//     quantityController.clear();

//     sizeController.clear();

//     descriptionController.clear();

//     selectedCategory.value = categories.first;

//     imagePath.value = "";

//     barcode.value = "";
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namma_kaimagga_app/models/product_model.dart';
import 'package:namma_kaimagga_app/product-list/product_list_controller.dart';

class AddProductController extends GetxController {
  //--------------------------------------------------
  // TEXT CONTROLLERS
  //--------------------------------------------------

  final productNameController = TextEditingController();

  final materialController = TextEditingController();

  final colourController = TextEditingController();

  final designController = TextEditingController();

  final lengthController = TextEditingController();

  final widthController = TextEditingController();

  final weightController = TextEditingController();

  final quantityController = TextEditingController();

  final priceController = TextEditingController();

  final manufactureDateController = TextEditingController();

  final remarksController = TextEditingController();

  //--------------------------------------------------
  // DROPDOWN
  //--------------------------------------------------

  final categories = <String>[
    "Saree",
    "Shawl",
    "Dress Material",
    "Kurta",
    "Dupatta",
    "Lungi",
    "Bedsheet",
    "Towel",
    "Scarf",
    "Fabric",
    "Other",
  ];

  RxString selectedCategory = "".obs;

  //--------------------------------------------------
  // BARCODE
  //--------------------------------------------------

  RxString generatedBarcode = "".obs;

  //--------------------------------------------------
  // IMAGE
  //--------------------------------------------------

  RxString productImagePath = "".obs;

  File get productImageFile => File(productImagePath.value);

  //--------------------------------------------------
  // INIT
  //--------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    generateBarcode();
  }

  @override
  void onClose() {
    productNameController.dispose();
    materialController.dispose();
    colourController.dispose();
    designController.dispose();

    lengthController.dispose();
    widthController.dispose();

    weightController.dispose();
    quantityController.dispose();
    priceController.dispose();

    manufactureDateController.dispose();

    remarksController.dispose();

    super.onClose();
  }

  //--------------------------------------------------
  // GENERATE BARCODE
  //--------------------------------------------------

  void generateBarcode() {
    final random = Random();

    generatedBarcode.value =
        "HL${DateTime.now().year}${100000 + random.nextInt(900000)}";
  }

  //--------------------------------------------------
  // DATE PICKER
  //--------------------------------------------------

  Future<void> pickManufactureDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (picked == null) return;

    manufactureDateController.text = DateFormat("dd-MM-yyyy").format(picked);
  }
  //--------------------------------------------------
  // CAPTURE PRODUCT IMAGE
  //--------------------------------------------------

  Future<void> captureProductImage() async {
    // TODO:
    // Replace with ImagePicker

    productImagePath.value = "";

    Get.snackbar(
      "Image",
      "Product image captured successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //--------------------------------------------------
  // SAVE PRODUCT
  //--------------------------------------------------

  void saveProduct() {
    if (materialController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Material");
      return;
    }

    if (colourController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Colour");
      return;
    }

    if (designController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Design");
      return;
    }

    if (manufactureDateController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Select Manufacturing Date");
      return;
    }
    if (productNameController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Product Name");

      return;
    }

    if (selectedCategory.value.isEmpty) {
      Get.snackbar("Validation", "Select Product Category");

      return;
    }

    if (weightController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Product Weight");

      return;
    }

    if (quantityController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Quantity");

      return;
    }

    if (priceController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Enter Product Price");

      return;
    }

    final product = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),

      productName: productNameController.text.trim(),

      category: selectedCategory.value,

      material: materialController.text.trim(),

      colour: colourController.text.trim(),

      design: designController.text.trim(),

      length: double.tryParse(lengthController.text.trim()) ?? 0.0,

      width: double.tryParse(widthController.text.trim()) ?? 0.0,

      weight: double.tryParse(weightController.text.trim()) ?? 0.0,

      quantity: int.tryParse(quantityController.text.trim()) ?? 0,

      price: double.tryParse(priceController.text.trim()) ?? 0.0,

      manufactureDate: manufactureDateController.text.trim(),

      barcode: generatedBarcode.value,

      imagePath: productImagePath.value,

      remarks: remarksController.text.trim(),
    );

    final productController = Get.find<ProductListController>();

    productController.addProduct(product);

    Get.back();

    Get.snackbar(
      "Success",
      "Product added successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
