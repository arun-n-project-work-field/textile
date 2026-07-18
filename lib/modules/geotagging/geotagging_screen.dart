import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'geotagging_controller.dart';

class GeoTaggingScreen extends GetView<GeoTaggingController> {
  const GeoTaggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GeoTaggingController());

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        title: const Text(
          "Geo Tagging",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              //----------------------------------
              // MAP CARD
              //----------------------------------

              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Stack(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.grey.shade300,
                      ),
                      child: const Center(
                        child: Text(
                          "ArcGIS Map Here",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 15,
                      top: 15,
                      child: Column(
                        children: [

                          FloatingActionButton.small(
                            heroTag: "gps",
                            backgroundColor: Colors.green,
                            onPressed: controller.getCurrentLocation,
                            child: const Icon(Icons.my_location),
                          ),

                          const SizedBox(height: 12),

                          FloatingActionButton.small(
                            heroTag: "layer",
                            backgroundColor: Colors.green,
                            onPressed: controller.changeMapType,
                            child: const Icon(Icons.layers),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //----------------------------------
              // LOCATION DETAILS
              //----------------------------------

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Obx(() => Column(
                        children: [

                          Row(
                            children: [

                              Expanded(
                                child: _infoTile(
                                  Icons.location_on,
                                  "Latitude",
                                  controller.latitude.value,
                                ),
                              ),

                              Expanded(
                                child: _infoTile(
                                  Icons.location_searching,
                                  "Longitude",
                                  controller.longitude.value,
                                ),
                              ),
                            ],
                          ),

                          const Divider(),

                          Row(
                            children: [

                              Expanded(
                                child: _infoTile(
                                  Icons.gps_fixed,
                                  "Accuracy",
                                  controller.accuracy.value,
                                ),
                              ),

                              Expanded(
                                child: _infoTile(
                                  Icons.access_time,
                                  "Time",
                                  controller.time.value,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),

              const SizedBox(height: 20),

              //----------------------------------
              // PHOTOS
              //----------------------------------

              Row(
                children: [

                  Expanded(
                    child: _photoCard(
                      "Photo 1",
                      controller.capturePhoto1,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _photoCard(
                      "Photo 2",
                      controller.capturePhoto2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //----------------------------------
              // BARCODE
              //----------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Barcode",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: controller.barcodeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.qr_code_scanner),
                            onPressed: controller.scanBarcode,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //----------------------------------
              // PRODUCT DETAILS
              //----------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [

                      TextField(
                        controller: controller.weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Product Weight (Kg)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: controller.remarksController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Remarks",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //----------------------------------
              // BUTTONS
              //----------------------------------

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
                      onPressed: controller.submitData,
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Column(
      children: [

        Icon(icon, color: Colors.green),

        const SizedBox(height: 8),

        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _photoCard(String title, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          height: 230,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.camera_alt,
                size: 70,
                color: Colors.green,
              ),

              const SizedBox(height: 20),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text("Tap to Capture"),
            ],
          ),
        ),
      ),
    );
  }
}