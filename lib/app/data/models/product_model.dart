// lib/app/data/models/product_model.dart
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        price: _parseDouble(json['price']),
        discountPercentage: _parseDouble(json['discountPercentage']),
        rating: _parseDouble(json['rating']),
        stock: json['stock'] ?? 0,
        brand: json['brand'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
        images: json['images'] != null
            ? List<String>.from(json['images'])
            : [],
      );
    } catch (e) {
      print('Error parsing Product: $e');
      // Return a fallback product with empty values
      return Product(
        id: 0,
        title: 'Error loading product',
        description: '',
        category: '',
        price: 0.0,
        discountPercentage: 0.0,
        rating: 0.0,
        stock: 0,
        brand: '',
        thumbnail: '',
        images: [],
      );
    }
  }

  // Helper method to safely parse numeric values
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }
}