// lib/app/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/product_response_model.dart';
import '../../../data/providers/product_provider.dart';

class HomeController extends GetxController {
  final ProductProvider productProvider = ProductProvider();
  final RxList<Product> products = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = ''.obs;
  final RxBool isLoading = true.obs;
  final RxString searchQuery = ''.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      ProductResponse response = await productProvider.getProducts();

      if (response.products.isEmpty) {
        errorMessage.value = 'No products found';
      } else {
        products.value = response.products;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load products: $e';
      print('Error in fetchProducts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      List<String> fetchedCategories = await productProvider.getCategories();
      categories.value = fetchedCategories;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      fetchProducts();
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
      searchQuery.value = query;
      selectedCategory.value = '';

      ProductResponse response = await productProvider.searchProducts(query);

      if (response.products.isEmpty) {
        errorMessage.value = 'No products found for "$query"';
      } else {
        products.value = response.products;
      }
    } catch (e) {
      errorMessage.value = 'Search failed: $e';
      print('Error in searchProducts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterByCategory(String category) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      searchQuery.value = '';
      selectedCategory.value = category;

      ProductResponse response = await productProvider.getProductsByCategory(category);

      if (response.products.isEmpty) {
        errorMessage.value = 'No products found in category "$category"';
      } else {
        products.value = response.products;
      }
    } catch (e) {
      errorMessage.value = 'Failed to filter products: $e';
      print('Error in filterByCategory: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetFilters() {
    searchQuery.value = '';
    selectedCategory.value = '';
    fetchProducts();
  }
}