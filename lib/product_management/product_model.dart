class ProductModel {
  final String name;
  final String category;
  final String barcode;
  final double weight;

  ProductModel({
    required this.name,
    required this.category,
    required this.barcode,
    required this.weight,
  });

  ProductModel copyWith({
    String? name,
    String? category,
    String? barcode,
    double? weight,
  }) {
    return ProductModel(
      name: name ?? this.name,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'barcode': barcode,
      'weight': weight,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      barcode: map['barcode'] ?? '',
      weight: (map['weight'] as num).toDouble(),
    );
  }
}