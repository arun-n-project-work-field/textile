import 'package:flutter/material.dart';

class SavedSurveyScreen extends StatelessWidget {
  const SavedSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Surveys"),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.sync),
        label: const Text("Sync"),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Pechan Number",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.storage, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  "Total Offline Records : 12",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text("${index + 1}"),
                    ),

                    title: Text("Pechan ID : 1000${index + 1}"),

                    subtitle: const Text(
                      "Ramesh Kumar\nCotton Weaver",
                    ),

                    trailing: PopupMenuButton(
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 1,
                          child: Text("View"),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text("Delete"),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text("Sync"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}