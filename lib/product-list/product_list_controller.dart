import 'package:get/get.dart';
import 'package:namma_kaimagga_app/models/product_model.dart';
import '../../routes/app_routes.dart';
import 'package:flutter/material.dart';




class ProductListController extends GetxController {

  //------------------------------------------------
  // Handloom ID
  //------------------------------------------------

  final String handloomId = "HLM000001";

  //------------------------------------------------
  // Product List
  //------------------------------------------------

  final RxList<ProductModel> products = <ProductModel>[].obs;

  //------------------------------------------------
  // Total Products
  //------------------------------------------------

  int get totalProducts => products.length;

  //------------------------------------------------
  // Total Amount
  //------------------------------------------------

  double get totalAmount {
    double total = 0;

    for (final product in products) {
      total += product.price * product.quantity;
    }

    return total;
  }

  //------------------------------------------------
  // Navigate to Add Product
  //------------------------------------------------

  void goToAddProduct() {
    Get.toNamed(AppRoutes.addProduct);
  }

  //------------------------------------------------
  // Add Product
  //------------------------------------------------

  void addProduct(ProductModel product) {
    products.add(product);
  }

  //------------------------------------------------
  // Edit Product
  //------------------------------------------------

  void editProduct(int index) {

    Get.toNamed(
      AppRoutes.addProduct,
      arguments: {
        "edit": true,
        "index": index,
        "product": products[index],
      },
    );
  }

  //------------------------------------------------
  // Delete Product
  //------------------------------------------------

  void deleteProduct(int index) {

    Get.defaultDialog(
      title: "Delete Product",
      middleText:
          "Are you sure you want to delete this product?",

      textConfirm: "Delete",
      textCancel: "Cancel",

      confirmTextColor: Colors.white,

      onConfirm: () {

        products.removeAt(index);

        Get.back();

        Get.snackbar(
          "Deleted",
          "Product deleted successfully.",
        );
      },
    );
  }

  //------------------------------------------------
  // Barcode
  //------------------------------------------------

  void viewBarcode(ProductModel product) {

    Get.defaultDialog(

      title: "Barcode",

      middleText:
          "Barcode Number\n\n${product.barcode}",

      textConfirm: "Close",

      confirmTextColor: Colors.white,

      onConfirm: () {

        Get.back();
      },
    );
  }

  //------------------------------------------------
  // Finish
  //------------------------------------------------

  void continueNext() {

    if (products.isEmpty) {

      Get.snackbar(
        "Products",
        "Please add at least one product.",
      );

      return;
    }

    Get.toNamed(AppRoutes.preview);
  }

  //------------------------------------------------
  // Dummy Data
  //------------------------------------------------

  @override
  void onInit() {

    super.onInit();

    // Uncomment for testing

    /*
    products.addAll([
      ProductModel(
        id: "1",
        productName: "Silk Saree",
        category: "Saree",
        barcode: "HL20260001",
        quantity: 2,
        weight: 1.2,
        price: 3500,
      ),
      ProductModel(
        id: "2",
        productName: "Cotton Shawl",
        category: "Shawl",
        barcode: "HL20260002",
        quantity: 5,
        weight: 0.8,
        price: 900,
      ),
    ]);
    */
  }
}