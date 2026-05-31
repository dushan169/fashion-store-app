import 'package:fashion_store_app/controllers/cart_controller.dart';
import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/models/product.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_store_app/controllers/wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    final WishlistController wishlistController = Get.find<WishlistController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('My Wishlist',
            style: AppTextStyle.withColour(AppTextStyle.h3, Theme.of(context).primaryColor)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      body: Obx(() {
        final favourites = wishlistController.wishlistItems;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildSummarySection(context, favourites.length, wishlistController)),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildWishlistItem(context, favourites[index], wishlistController),
                  childCount: favourites.length,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSummarySection(BuildContext context, int count, WishlistController wishlistController) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$count Items',
              style: AppTextStyle.withColour(
                  AppTextStyle.h2, Theme.of(context).textTheme.bodyMedium!.color!)),
          const SizedBox(height: 4),
          Text('in your wishlist',
              style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!)),
        ]),
        ElevatedButton(
          onPressed: () {
            final cartController = Get.find<CartController>();
            for (var product in wishlistController.wishlistItems) {
              cartController.addToCart(product);
            }
            Get.snackbar('Cart', 'All wishlist items added to cart!');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text('Add All to Cart',
              style: AppTextStyle.withColour(AppTextStyle.bodySmall, Colors.white)),
        ),
      ]),
    );
  }

  Widget _buildWishlistItem(BuildContext context, Product product, WishlistController wishlistController) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
          child: product.imageUrl.startsWith('http')
              ? Image.network(product.imageUrl, width: 120, height: 120, fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.image, size: 60, color: Colors.grey))
              : Image.asset(product.imageUrl, width: 120, height: 120, fit: BoxFit.cover),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product.name,
                  style: AppTextStyle.withColour(
                      AppTextStyle.h3, Theme.of(context).textTheme.bodyMedium!.color!)),
              const SizedBox(height: 4),
              Text(product.category,
                  style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!)),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('LKR ${product.price.toStringAsFixed(2)}',
                    style: AppTextStyle.withColour(
                        AppTextStyle.h3, Theme.of(context).textTheme.bodyMedium!.color!)),
                Row(children: [
                  IconButton(onPressed: () {
                    final cartController = Get.find<CartController>();
    cartController.addToCart(product);
                  },
                      icon: Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor)),
                  IconButton(
                    onPressed: () => wishlistController.toggleWishlist(product),
                    icon: Icon(Icons.delete_outline,
                        color: isDark ? Colors.grey[400]! : Colors.grey[600]!)),
                ]),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }
}
