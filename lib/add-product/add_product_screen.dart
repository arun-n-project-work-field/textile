// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'add_product_controller.dart';

// class AddProductScreen extends StatelessWidget {
//   AddProductScreen({super.key});

//   final AddProductController controller = Get.find<AddProductController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7FA),

//       appBar: AppBar(
//         backgroundColor: Colors.green.shade800,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Add Product",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),

//           child: Column(
//             children: [
//               //-------------------------------------------------
//               // PRODUCT INFORMATION
//               //-------------------------------------------------
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),

//                 child: Padding(
//                   padding: const EdgeInsets.all(18),

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [
//                       const Text(
//                         "Product Information",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       TextField(
//                         controller: controller.productNameController,

//                         decoration: InputDecoration(
//                           labelText: "Product Name",

//                           prefixIcon: const Icon(Icons.shopping_bag),

//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       DropdownButtonFormField<String>(
//                         initialValue: controller.selectedCategory.value,

//                         decoration: InputDecoration(
//                           labelText: "Category",

//                           prefixIcon: const Icon(Icons.category),

//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),

//                         items: controller.categories
//                             .map(
//                               (e) => DropdownMenuItem(value: e, child: Text(e)),
//                             )
//                             .toList(),

//                         onChanged: controller.changeCategory,
//                       ),

//                       const SizedBox(height: 18),

//                       TextField(
//                         controller: controller.materialController,

//                         decoration: InputDecoration(
//                           labelText: "Material",

//                           prefixIcon: const Icon(Icons.texture),

//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       TextField(
//                         controller: controller.colorController,

//                         decoration: InputDecoration(
//                           labelText: "Colour",

//                           prefixIcon: const Icon(Icons.palette),

//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       TextField(
//                         controller: controller.weightController,

//                         keyboardType: TextInputType.number,

//                         decoration: InputDecoration(
//                           labelText: "Weight (Kg)",

//                           prefixIcon: const Icon(Icons.scale),

//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       TextField(
//                         controller: controller.priceController,

//                         keyboardType: TextInputType.number,

//                         decoration: InputDecoration(
//                           labelText: "Selling Price",

//                           prefixIcon: const Icon(Icons.currency_rupee),

//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       TextField(
//                         controller: controller.quantityController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "Quantity",
//                           prefixIcon: const Icon(Icons.inventory_2),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       TextField(
//                         controller: controller.sizeController,
//                         decoration: InputDecoration(
//                           labelText: "Size / Dimensions",
//                           prefixIcon: const Icon(Icons.straighten),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       TextField(
//                         controller: controller.descriptionController,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           labelText: "Product Description",
//                           alignLabelWithHint: true,
//                           prefixIcon: const Padding(
//                             padding: EdgeInsets.only(bottom: 70),
//                             child: Icon(Icons.description),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //---------------------------------------------------
//               // PRODUCT IMAGE
//               //---------------------------------------------------
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Product Image",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       Obx(
//                         () => InkWell(
//                           onTap: controller.captureImage,
//                           borderRadius: BorderRadius.circular(15),
//                           child: Container(
//                             height: 220,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(color: Colors.grey.shade400),
//                             ),
//                             child: controller.imagePath.value.isEmpty
//                                 ? const Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.camera_alt,
//                                         size: 60,
//                                         color: Colors.green,
//                                       ),
//                                       SizedBox(height: 15),
//                                       Text("Tap to Capture Product Image"),
//                                     ],
//                                   )
//                                 : ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.asset(
//                                       controller.imagePath.value,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //---------------------------------------------------
//               // BARCODE
//               //---------------------------------------------------
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Barcode / QR Code",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       Obx(
//                         () => TextField(
//                           readOnly: true,
//                           controller: TextEditingController(
//                             text: controller.barcode.value,
//                           ),
//                           decoration: InputDecoration(
//                             labelText: "Generated Barcode",
//                             prefixIcon: const Icon(Icons.qr_code),
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.refresh),
//                               onPressed: controller.generateBarcode,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: controller.generateBarcode,
//                           icon: const Icon(Icons.qr_code_2),
//                           label: const Text(
//                             "Generate Barcode",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.deepPurple,
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size.fromHeight(55),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: controller.saveProduct,
//                           icon: const Icon(Icons.save),
//                           label: const Text(
//                             "Save Product",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size.fromHeight(55),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: controller.saveAndAddAnother,
//                           icon: const Icon(Icons.add_box),
//                           label: const Text(
//                             "Save & Add Another Product",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size.fromHeight(55),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       SizedBox(
//                         width: double.infinity,
//                         child: OutlinedButton.icon(
//                           onPressed: controller.finish,
//                           icon: const Icon(Icons.check_circle),
//                           label: const Text(
//                             "Finish & Return to Product List",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             minimumSize: const Size.fromHeight(55),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_product_controller.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final AddProductController controller =
      Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Add Product",
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

              //---------------------------------------
              // PRODUCT INFORMATION
              //---------------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Product Information",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller:
                            controller.productNameController,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          prefixIcon:
                              const Icon(Icons.shopping_bag),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: controller.selectedCategory.value.isEmpty
                            ? null
                            : controller.selectedCategory.value,

                        decoration: InputDecoration(
                          labelText: "Category",
                          prefixIcon:
                              const Icon(Icons.category),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
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
                          controller.selectedCategory.value =
                              value!;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller:
                            controller.materialController,
                        decoration: InputDecoration(
                          labelText: "Material",
                          prefixIcon:
                              const Icon(Icons.layers),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller:
                            controller.colourController,
                        decoration: InputDecoration(
                          labelText: "Colour",
                          prefixIcon:
                              const Icon(Icons.palette),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller:
                            controller.designController,
                        decoration: InputDecoration(
                          labelText: "Design / Pattern",
                          prefixIcon:
                              const Icon(Icons.texture),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),
                                            const SizedBox(height: 16),

                      Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller:
                                  controller.lengthController,
                              keyboardType:
                                  TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Length (cm)",
                                prefixIcon: const Icon(Icons.straighten),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: TextField(
                              controller:
                                  controller.widthController,
                              keyboardType:
                                  TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Width (cm)",
                                prefixIcon: const Icon(Icons.width_normal),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller:
                                  controller.weightController,
                              keyboardType:
                                  TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Weight (Kg)",
                                prefixIcon:
                                    const Icon(Icons.scale),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: TextField(
                              controller:
                                  controller.quantityController,
                              keyboardType:
                                  TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Quantity",
                                prefixIcon:
                                    const Icon(Icons.inventory_2),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller:
                            controller.priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Price (₹)",
                          prefixIcon:
                              const Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller:
                            controller.manufactureDateController,
                        readOnly: true,
                        onTap: controller.pickManufactureDate,
                        decoration: InputDecoration(
                          labelText: "Manufacturing Date",
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

                      const SizedBox(height: 24),

                      //-----------------------------------
                      // BARCODE
                      //-----------------------------------

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [

                            const Icon(
                              Icons.qr_code_2,
                              size: 70,
                              color: Colors.green,
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Generated Barcode",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Obx(
                              () => SelectableText(
                                controller.generatedBarcode.value,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            ElevatedButton.icon(
                              onPressed:
                                  controller.generateBarcode,
                              icon: const Icon(Icons.refresh),
                              label: const Text(
                                "Generate Barcode",
                              ),
                            ),
                          ],
                        ),
                      ),
                                            const SizedBox(height: 24),

                      //---------------------------------------
                      // PRODUCT IMAGE
                      //---------------------------------------

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [

                            Obx(
                              () => controller.productImagePath.value.isEmpty
                                  ? const Icon(
                                      Icons.image,
                                      size: 90,
                                      color: Colors.grey,
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      child: Image.file(
                                        controller.productImageFile,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton.icon(
                              onPressed:
                                  controller.captureProductImage,
                              icon: const Icon(
                                  Icons.camera_alt),
                              label: const Text(
                                  "Capture Product Image"),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      //---------------------------------------
                      // REMARKS
                      //---------------------------------------

                      TextField(
                        controller:
                            controller.remarksController,
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

                      const SizedBox(height: 30),

                      //---------------------------------------
                      // BUTTONS
                      //---------------------------------------

                      Row(
                        children: [

                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize:
                                    const Size.fromHeight(55),
                              ),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed:
                                  controller.saveProduct,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green,
                                foregroundColor:
                                    Colors.white,
                                minimumSize:
                                    const Size.fromHeight(55),
                              ),
                              icon: const Icon(
                                Icons.save,
                              ),
                              label: const Text(
                                "Save Product",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}