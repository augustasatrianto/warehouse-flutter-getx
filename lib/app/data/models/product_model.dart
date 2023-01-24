class ProductModel {
  ProductModel({
    required this.code,
    required this.name,
    required this.productId,
    required this.qty,
    required this.unit,
  });

  final String code;
  final String name;
  final String productId;
  final int qty;
  final String unit;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        productId: json["productId"] ?? "",
        qty: json["qty"] ?? 0,
        unit: json["unit"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "productId": productId,
        "qty": qty,
        "unit": unit,
      };
}
