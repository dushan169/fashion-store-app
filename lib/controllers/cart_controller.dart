import 'package:fashion_store_app/models/product.dart';
import 'package:get/get.dart';

class CartItem {
  final Product product;
  int quantity;
  String selectedSize;

  CartItem({required this.product, this.quantity = 1, this.selectedSize = 'M'});
}

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  void addToCart(Product product, {String size = 'M'}) {
    final existingIndex = cartItems.indexWhere(
        (item) => item.product.id == product.id && item.selectedSize == size);
    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product, selectedSize: size));
    }
    Get.snackbar('Cart', '${product.name} added to cart!');
  }

  void removeFromCart(int index) => cartItems.removeAt(index);

  void increaseQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      cartItems.removeAt(index);
    }
  }

  void clearCart() => cartItems.clear();

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  double get deliveryCharge => totalPrice > 5000 ? 0 : 350;
  double get grandTotal => totalPrice + deliveryCharge;
  bool get isEmpty => cartItems.isEmpty;
}
