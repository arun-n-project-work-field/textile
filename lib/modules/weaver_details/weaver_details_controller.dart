import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeaverDetailsController extends GetxController {
  final beneficiaryId = TextEditingController(text: "HK001245");
  final weaverName = TextEditingController(text: "Ramesh Kumar");
  final fatherName = TextEditingController(text: "Shivappa");
  final mobile = TextEditingController(text: "9876543210");
  final district = TextEditingController(text: "Mysuru");
  final taluk = TextEditingController(text: "Mysuru");
  final village = TextEditingController(text: "Bogadi");
  final address = TextEditingController(text: "12, Main Road, Bogadi, Mysuru");
}
