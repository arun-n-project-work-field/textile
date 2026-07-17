import 'package:get/get.dart';

class Weaver {
  final String id;
  final String name;
  final String father;
  final String village;

  Weaver({
    required this.id,
    required this.name,
    required this.father,
    required this.village,
  });
}

class WeaverListController extends GetxController {
  final weavers = <Weaver>[
    Weaver(
      id: "HK001245",
      name: "Ramesh Kumar",
      father: "Shivappa",
      village: "Mysuru",
    ),
    Weaver(
      id: "HK001246",
      name: "Suresh",
      father: "Hanumanth",
      village: "Mandya",
    ),
    Weaver(
      id: "HK001247",
      name: "Lakshmi",
      father: "Narayana",
      village: "Tumakuru",
    ),
    Weaver(
      id: "HK001248",
      name: "Manjunath",
      father: "Ranga",
      village: "Belagavi",
    ),
    Weaver(
      id: "HK001249",
      name: "Geetha",
      father: "Krishna",
      village: "Hassan",
    ),
  ].obs;
}
