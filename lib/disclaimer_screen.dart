import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disclaimer",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Text("Map boundaries are only for reference and not fit for legal use.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ),)
        ],
      ),
    );
  }
}