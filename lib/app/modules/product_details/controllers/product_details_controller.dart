import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class ProductDetailsController extends GetxController {
  Rx<Product> product = Rx<Product>(Get.arguments);
  RxInt currentImageIndex = 0.obs;

  void changeImage(int index) {
    currentImageIndex.value = index;
  }
}