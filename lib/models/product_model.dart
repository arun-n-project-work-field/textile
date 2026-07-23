class ProductModel {
  final String id;

  final String productName;

  final String category;

  final String material;

  final String colour;

  final String design;

  final double length;

  final double width;

  final double weight;

  final int quantity;

  final double price;

  final String manufactureDate;

  final String barcode;

  final String imagePath;

  final String remarks;

  ProductModel({
    required this.id,
    required this.productName,
    required this.category,
    required this.material,
    required this.colour,
    required this.design,
    required this.length,
    required this.width,
    required this.weight,
    required this.quantity,
    required this.price,
    required this.manufactureDate,
    required this.barcode,
    required this.imagePath,
    required this.remarks,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: json["id"] ?? "",

      productName: json["productName"] ?? "",

      category: json["category"] ?? "",

      material: json["material"] ?? "",

      colour: json["colour"] ?? "",

      design: json["design"] ?? "",

      length: (json["length"] ?? 0).toDouble(),

      width: (json["width"] ?? 0).toDouble(),

      weight: (json["weight"] ?? 0).toDouble(),

      quantity: json["quantity"] ?? 0,

      price: (json["price"] ?? 0).toDouble(),

      manufactureDate:
          json["manufactureDate"] ?? "",

      barcode: json["barcode"] ?? "",

      imagePath: json["imagePath"] ?? "",

      remarks: json["remarks"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "productName": productName,

      "category": category,

      "material": material,

      "colour": colour,

      "design": design,

      "length": length,

      "width": width,

      "weight": weight,

      "quantity": quantity,

      "price": price,

      "manufactureDate": manufactureDate,

      "barcode": barcode,

      "imagePath": imagePath,

      "remarks": remarks,
    };
  }

  ProductModel copyWith({
    String? id,
    String? productName,
    String? category,
    String? material,
    String? colour,
    String? design,
    double? length,
    double? width,
    double? weight,
    int? quantity,
    double? price,
    String? manufactureDate,
    String? barcode,
    String? imagePath,
    String? remarks,
  }) {
    return ProductModel(
      id: id ?? this.id,

      productName:
          productName ?? this.productName,

      category: category ?? this.category,

      material: material ?? this.material,

      colour: colour ?? this.colour,

      design: design ?? this.design,

      length: length ?? this.length,

      width: width ?? this.width,

      weight: weight ?? this.weight,

      quantity: quantity ?? this.quantity,

      price: price ?? this.price,

      manufactureDate:
          manufactureDate ??
              this.manufactureDate,

      barcode: barcode ?? this.barcode,

      imagePath:
          imagePath ?? this.imagePath,

      remarks: remarks ?? this.remarks,
    );
  }

  @override
  String toString() {
    return '''
ProductModel(
  id: $id,
  productName: $productName,
  category: $category,
  material: $material,
  colour: $colour,
  design: $design,
  length: $length,
  width: $width,
  weight: $weight,
  quantity: $quantity,
  price: $price,
  manufactureDate: $manufactureDate,
  barcode: $barcode,
  imagePath: $imagePath,
  remarks: $remarks,
)
''';
  }
}