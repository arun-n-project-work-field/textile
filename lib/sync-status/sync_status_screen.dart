import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sync_status_controller.dart';

class SyncStatusScreen extends StatelessWidget {
  SyncStatusScreen({super.key});

  final SyncStatusController controller =
      Get.find<SyncStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Sync Status",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.surveys.length,
          itemBuilder: (context, index) {

            final survey = controller.surveys[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            survey.barcode,
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        Chip(
                          backgroundColor:
                              survey.synced
                                  ? Colors.green
                                  : Colors.orange,

                          label: Text(
                            survey.synced
                                ? "Synced"
                                : "Pending",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                        "Products : ${survey.productCount}"),

                    Text(
                        "Latitude : ${survey.latitude}"),

                    Text(
                        "Longitude : ${survey.longitude}"),

                    const SizedBox(height: 20),
                                        Row(
                      children: [

                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                controller.deleteSurvey(index),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            label: const Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: survey.synced
                                ? null
                                : () => controller.syncSurvey(index),
                            icon: const Icon(Icons.cloud_upload),
                            label: Text(
                              survey.synced
                                  ? "Uploaded"
                                  : "Upload",
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  const Size.fromHeight(45),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      //-----------------------------------------
      // SYNC ALL BUTTON
      //-----------------------------------------

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 58,
            child: ElevatedButton.icon(
              onPressed: controller.syncAll,
              icon: const Icon(Icons.cloud_sync),
              label: const Text(
                "Sync All Pending Surveys",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
