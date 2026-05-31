import 'package:fashion_store_app/models/product.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final RxList<Product> wishlistItems = <Product>[].obs;

  bool isWishlisted(Product product) {
    return wishlistItems.any((item) => item.id == product.id);
  }

  void toggleWishlist(Product product) {
    if (isWishlisted(product)) {
      wishlistItems.removeWhere((item) => item.id == product.id);
      Get.snackbar('Wishlist', '${product.name} removed from wishlist!');
    } else {
      wishlistItems.add(product);
      Get.snackbar('Wishlist', '${product.name} added to wishlist!');
    }
  }
}