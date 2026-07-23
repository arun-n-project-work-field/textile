import 'package:flutter/material.dart';

class SyncDataScreen extends StatelessWidget {
  const SyncDataScreen({super.key});

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
          "Synchronize Handloom Data",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            //--------------------------------------------------
            // HEADER
            //--------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade800,
                    Colors.green.shade500,
                  ],
                ),
              ),
              child: const Column(
                children: [

                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.cloud_sync,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),

                  SizedBox(height: 18),

                  Text(
                    "Offline Synchronization",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Upload geo-tagged handloom records,\nproducts and QR codes to the server.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // SUMMARY
            //--------------------------------------------------

            Row(
              children: [

                Expanded(
                  child: _summaryCard(
                    title: "Handlooms",
                    value: "12",
                    icon: Icons.home_work,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    title: "Products",
                    value: "53",
                    icon: Icons.shopping_bag,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: _summaryCard(
                    title: "Pending",
                    value: "12",
                    icon: Icons.cloud_upload,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    title: "Synced",
                    value: "41",
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Offline Records",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                                                  //--------------------------------------------------
                          // HANDLOOM HEADER
                          //--------------------------------------------------

                          Row(
                            children: [

                              CircleAvatar(
                                radius: 26,
                                backgroundColor:
                                    Colors.green.shade100,
                                child: Icon(
                                  Icons.home_work,
                                  color:
                                      Colors.green.shade800,
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Handloom ID : HLM2026${(index + 1).toString().padLeft(4, '0')}",
                                      style: const TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      "Geo Tagged Handloom",
                                      style: TextStyle(
                                        color:
                                            Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Pending",
                                  style: TextStyle(
                                    color:
                                        Colors.orange.shade800,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          const Divider(),

                          const SizedBox(height: 15),

                          //--------------------------------------------------
                          // INFORMATION
                          //--------------------------------------------------

                          Row(
                            children: [

                              Expanded(
                                child: _infoTile(
                                  Icons.shopping_bag,
                                  "Products",
                                  "${index % 5 + 2}",
                                ),
                              ),

                              Expanded(
                                child: _infoTile(
                                  Icons.qr_code,
                                  "QR Codes",
                                  "${index % 5 + 2}",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [

                              Expanded(
                                child: _infoTile(
                                  Icons.location_on,
                                  "Geo Tag",
                                  "Completed",
                                ),
                              ),

                              Expanded(
                                child: _infoTile(
                                  Icons.photo_camera,
                                  "Images",
                                  "2",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  Colors.green.shade50,
                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                            ),
                            child: Row(
                              children: [

                                Icon(
                                  Icons.check_circle,
                                  color:
                                      Colors.green.shade700,
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    "Ready for synchronization",
                                    style: TextStyle(
                                      color:
                                          Colors.green.shade800,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ),

                                Icon(
                                  Icons.cloud_upload,
                                  color:
                                      Colors.green.shade700,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
                        //--------------------------------------------------
            // SYNC PROGRESS
            //--------------------------------------------------

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [

                    Row(
                      children: const [

                        Icon(
                          Icons.sync,
                          color: Colors.green,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Synchronization Progress",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const LinearProgressIndicator(
                      value: 0.65,
                      minHeight: 10,
                    ),

                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [

                        Text("Uploaded"),
                        Text("8 / 12"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // SYNC BUTTON
            //--------------------------------------------------

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload),
                label: const Text(
                  "Sync Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        title: const Center(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 70,
                          ),
                        ),

                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Text(
                              "Synchronization Completed",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 20),

                            ListTile(
                              leading: Icon(
                                Icons.home_work,
                                color: Colors.green,
                              ),
                              title: Text(
                                  "12 Handloom Records Uploaded"),
                            ),

                            ListTile(
                              leading: Icon(
                                Icons.shopping_bag,
                                color: Colors.orange,
                              ),
                              title:
                                  Text("53 Products Uploaded"),
                            ),

                            ListTile(
                              leading: Icon(
                                Icons.qr_code,
                                color: Colors.blue,
                              ),
                              title:
                                  Text("53 QR Codes Linked"),
                            ),

                            ListTile(
                              leading: Icon(
                                Icons.cloud_done,
                                color: Colors.green,
                              ),
                              title: Text(
                                  "Successfully Synced"),
                            ),
                          ],
                        ),

                        actions: [

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {

                                Navigator.pop(context);

                              },
                              child: const Text("OK"),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------
  // SUMMARY CARD
  //--------------------------------------------------

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            CircleAvatar(
              backgroundColor:
                  color.withOpacity(0.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------
  // INFO TILE
  //--------------------------------------------------

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: Colors.green,
          size: 22,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}