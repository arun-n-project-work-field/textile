import 'package:flutter/material.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Text("Name : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          SizedBox(width: 20,),
          Text("Namma Kaimagga"),
          Text("Version : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          SizedBox(width: 20,),
          Text("Description : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          Text("This mobile application is developed for the identification and geo-tagging of Handloom weaver location and photo of the handlooms along with the weaver in Karnataka."),
          SizedBox(width: 20,),
          Text("Developed By : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          Text("Karnataka-GIS, KSRSAC"),
          SizedBox(width: 20,),
          Text("KGIS : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          Text("https://kgis.ksrsac.in/kgis/"),
          SizedBox(width: 20,),
          Text("KSRSAC : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          Text("https://ksrsac.karnataka.gov.in"),
        ],
      ),
    );
  }
}