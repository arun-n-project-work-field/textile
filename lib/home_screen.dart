import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Namma Kaimagga App", style: TextStyle(color: Colors.white),),
         actions: [
            TextButton(
              onPressed: (){},
              child: const Text(
                "About App",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed:(){} ,
              child: const Text(
                "Disclaimer",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
      ),
    );
  }
}