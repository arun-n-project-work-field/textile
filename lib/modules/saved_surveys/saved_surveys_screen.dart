// import 'package:flutter/material.dart';

// class SavedSurveysScreen extends StatelessWidget {
//   const SavedSurveysScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7FA),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         title: const Text(
//           "Saved Surveys",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: Colors.blue,
//         onPressed: () {},
//         icon: const Icon(Icons.sync, color: Colors.white),
//         label: const Text("Sync", style: TextStyle(color: Colors.white)),
//       ),

//       body: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(16),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Search Weaver",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: 12,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 3,
//                   margin: const EdgeInsets.only(bottom: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18),
//                   ),

//                   child: Padding(
//                     padding: const EdgeInsets.all(16),

//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 28,
//                               backgroundColor: Colors.blue.shade100,
//                               child: const Icon(
//                                 Icons.person,
//                                 color: Colors.blue,
//                               ),
//                             ),

//                             const SizedBox(width: 16),

//                             const Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Ramesh Kumar",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     ),
//                                   ),

//                                   SizedBox(height: 5),

//                                   Text("Beneficiary ID : NK000123"),

//                                   SizedBox(height: 3),

//                                   Text("Village : Mysore"),
//                                 ],
//                               ),
//                             ),

//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade100,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: const Text(
//                                 "Offline",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 18),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                   foregroundColor: Colors.white,
//                                 ),
//                                 onPressed: () {},
//                                 icon: const Icon(Icons.edit),
//                                 label: const Text("Edit"),
//                               ),
//                             ),

//                             const SizedBox(width: 10),

//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                   foregroundColor: Colors.white,
//                                 ),
//                                 onPressed: () {},
//                                 icon: const Icon(Icons.cloud_upload),
//                                 label: const Text("Upload"),
//                               ),
//                             ),

//                             const SizedBox(width: 10),

//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
