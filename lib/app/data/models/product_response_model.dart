// lib/app/data/models/product_response_model.dart
import 'package:product_app/app/data/models/product_model.dart';

class ProductResponse {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductResponse({
    required this.products,
    this.total = 0,
    this.skip = 0,
    this.limit = 0,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    try {
      return ProductResponse(
        products: json['products'] != null
            ? List<Product>.from(
            json['products'].map((x) => Product.fromJson(x)))
            : [],
        total: json['total'] ?? 0,
        skip: json['skip'] ?? 0,
        limit: json['limit'] ?? 0,
      );
    } catch (e) {
      print('Error parsing ProductResponse: $e');
      return ProductResponse(products: []);
    }
  }
}