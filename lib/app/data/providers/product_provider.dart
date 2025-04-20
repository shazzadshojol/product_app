// lib/app/data/providers/product_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_response_model.dart';

class ProductProvider {
  static const String baseUrl = 'https://dummyjson.com';

  Future<ProductResponse> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products?limit=30'));
      if (response.statusCode == 200) {
        print('Failed to load products: ${response.statusCode}');
        print('Failed to load products: ${response.body}');
        return ProductResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<ProductResponse> searchProducts(String query) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/products/search?q=$query'));
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/products/categories'));
      if (response.statusCode == 200) {
        return List<String>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<ProductResponse> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/products/category/$category'));
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load products by category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products by category: $e');
    }
  }
}