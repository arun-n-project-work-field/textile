import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_details_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final ProductDetailsController controller =
      Get.find<ProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Handloom Product Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              //-----------------------------------------
              // PRODUCT INFORMATION
              //-----------------------------------------

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Product Information",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: controller.productNameController,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          prefixIcon: const Icon(Icons.shopping_bag),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.selectedCategory.value,

                          decoration: InputDecoration(
                            labelText: "Product Category",
                            prefixIcon: const Icon(Icons.category),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          items: controller.categories
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),

                          onChanged: (value) {
                            controller.selectedCategory.value = value!;
                          },
                        ),
                      ),

                      const SizedBox(height: 18),

                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.selectedFabric.value,

                          decoration: InputDecoration(
                            labelText: "Fabric Type",
                            prefixIcon: const Icon(Icons.texture),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          items: controller.fabricTypes
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),

                          onChanged: (value) {
                            controller.selectedFabric.value = value!;
                          },
                        ),
                      ),

                      const SizedBox(height: 18),

                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.selectedTechnique.value,

                          decoration: InputDecoration(
                            labelText: "Weaving Technique",
                            prefixIcon: const Icon(Icons.handyman),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          items: controller.weavingTechniques
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),

                          onChanged: (value) {
                            controller.selectedTechnique.value = value!;
                          },
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: controller.colourController,
                        decoration: InputDecoration(
                          labelText: "Colour",
                          prefixIcon: const Icon(Icons.palette),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: controller.patternController,
                        decoration: InputDecoration(
                          labelText: "Design / Pattern",
                          prefixIcon: const Icon(Icons.design_services),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller: controller.lengthController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Length (m)",
                                prefixIcon:
                                    const Icon(Icons.straighten),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: TextField(
                              controller: controller.widthController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Width (m)",
                                prefixIcon:
                                    const Icon(Icons.straighten),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: controller.weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Weight (Kg)",
                          prefixIcon: const Icon(Icons.scale),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      GestureDetector(
                        onTap: controller.pickProductionDate,
                        child: AbsorbPointer(
                          child: TextField(
                            controller:
                                controller.productionDateController,
                            decoration: InputDecoration(
                              labelText: "Production Date",
                              prefixIcon:
                                  const Icon(Icons.calendar_today),
                              suffixIcon:
                                  const Icon(Icons.arrow_drop_down),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //-----------------------------------------
              // PRODUCT IDENTIFICATION
              //-----------------------------------------

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Product Identification",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: controller.productIdController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Product ID",
                          prefixIcon:
                              const Icon(Icons.qr_code),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: controller.batchController,
                        decoration: InputDecoration(
                          labelText: "Batch Number",
                          prefixIcon:
                              const Icon(Icons.confirmation_number),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: controller.remarksController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Remarks",
                          alignLabelWithHint: true,
                          prefixIcon:
                              const Icon(Icons.notes),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
                            //-----------------------------------------
              // PRODUCT IMAGES
              //-----------------------------------------

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Product Images",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [

                          Expanded(
                            child: _imageCard(
                              title: "Front Image",
                              icon: Icons.photo_camera,
                              onTap: controller.captureFrontImage,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: _imageCard(
                              title: "Back Image",
                              icon: Icons.photo_camera_back,
                              onTap: controller.captureBackImage,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      _imageCard(
                        title: "Close-up Image",
                        icon: Icons.zoom_in,
                        onTap: controller.captureCloseupImage,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //-----------------------------------------
              // BARCODE
              //-----------------------------------------

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Barcode / QR Code",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: controller.barcodeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Barcode Number",
                          prefixIcon: const Icon(Icons.qr_code),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Obx(
                          () => Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            child: controller.barcodeGenerated.value
                                ? const Icon(
                                    Icons.qr_code_2,
                                    size: 150,
                                    color: Colors.black,
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: const [

                                      Icon(
                                        Icons.qr_code,
                                        size: 70,
                                        color: Colors.grey,
                                      ),

                                      SizedBox(height: 10),

                                      Text(
                                        "QR Code will appear here",
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: controller.generateBarcode,
                          icon: const Icon(Icons.qr_code),
                          label: const Text("Generate Barcode"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            minimumSize:
                                const Size(double.infinity, 55),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              //-----------------------------------------
              // ACTION BUTTONS
              //-----------------------------------------

              Row(
                children: [

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.saveDraft,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Draft"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.previewProduct,
                      icon: const Icon(Icons.preview),
                      label: const Text("Preview"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.saveAndContinue,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Save & Continue"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 58),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: SizedBox(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                icon,
                size: 60,
                color: Colors.green,
              ),

              const SizedBox(height: 15),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Tap to Capture",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}