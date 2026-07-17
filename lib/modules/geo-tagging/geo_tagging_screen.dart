import 'package:flutter/material.dart';

class GeoTaggingScreen extends StatelessWidget {
  const GeoTaggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geo Tagging"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Stack(
        children: [
          /// MAP
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade300,
            child: Stack(
              children: [
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 120,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ArcGIS Map",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Map will be integrated later",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  right: 15,
                  top: 20,
                  child: Column(
                    children: [
                      FloatingActionButton.small(
                        heroTag: "gps",
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 12),

                      FloatingActionButton.small(
                        heroTag: "plus",
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),

                      const SizedBox(height: 12),

                      FloatingActionButton.small(
                        heroTag: "minus",
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM SHEET
          DraggableScrollableSheet(
            initialChildSize: .35,
            minChildSize: .28,
            maxChildSize: .80,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),

                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    Center(
                      child: Container(
                        width: 55,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Current Location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("Latitude"),
                        subtitle: Text("12.971600"),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.explore,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("Longitude"),
                        subtitle: Text("77.594600"),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.gps_fixed,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("GPS Accuracy"),
                        subtitle: Text("± 4.5 meters"),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 55,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.gps_fixed),
                        label: const Text(
                          "Capture Current Location",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      height: 55,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                          "Refresh GPS",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}