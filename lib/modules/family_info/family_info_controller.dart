import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyInfoController extends GetxController {
  final familyHeadController = TextEditingController();
  final rationCardController = TextEditingController();
  final aadhaarController = TextEditingController();
  final occupationController = TextEditingController();
  final annualIncomeController = TextEditingController();

  final totalMembers = TextEditingController(text: "5");
  final maleMembers = TextEditingController(text: "2");
  final femaleMembers = TextEditingController(text: "2");
  final children = TextEditingController(text: "1");

  final familyType = "Joint".obs;
}
