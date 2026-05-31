import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/controllers/wishlist_controller.dart';
import 'package:fashion_store_app/view/product_details_screen.dart';
import 'package:fashion_store_app/view/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    final WishlistController wishlistController = Get.find<WishlistController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final products = controller.filteredProducts;
      if (products.isEmpty) {
        return const Center(child: Text('No products found'));
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product)),
            ),
            child: ProductCard(
              product: product,
              wishlistController: wishlistController,
            ),
          );
        },
      );
    });
  }
}
