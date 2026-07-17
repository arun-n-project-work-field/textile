import 'package:flutter/material.dart';

class SyncDataScreen extends StatelessWidget {
  const SyncDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Sync Data",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff1565C0),
                    Color(0xff42A5F5),
                  ],
                ),
              ),
              child: const Column(
                children: [

                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.sync,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),

                  SizedBox(height: 15),

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
                    "Upload locally saved survey records.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  )

                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.storage, color: Colors.white),
                ),
                title: Text(
                  "Offline Records",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("12 records waiting for synchronization"),
                trailing: Text(
                  "12",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text("Pechan ID : 1000${index + 1}"),
                      subtitle: const Text("Ready for Upload"),
                      trailing: const Icon(
                        Icons.cloud_upload,
                        color: Colors.green,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload),
                label: const Text(
                  "Sync Now",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Synchronization Started"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

          ],
        ),
      ),
    );
  }
}








