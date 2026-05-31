import 'package:fashion_store_app/controllers/cart_controller.dart';
import 'package:fashion_store_app/features/checkout/screens/checkout_screen.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
        ),
        backgroundColor: const Color.fromARGB(230, 20, 20, 20),
        title: Text('My Cart',
            style: AppTextStyle.withColour(AppTextStyle.h3, Theme.of(context).primaryColor)),
      ),
      body: Obx(() {
        if (cart.isEmpty) {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              Text('Your cart is empty',
                  style: AppTextStyle.withColour(AppTextStyle.bodyLarge, Colors.grey)),
            ]),
          );
        }
        return Column(children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) =>
                  _buildCartItem(context, cart, index),
            ),
          ),
          _buildCartSummary(context, cart),
        ]);
      }),
    );
  }

  Widget _buildCartItem(BuildContext context, CartController cart, int index) {
    final item = cart.cartItems[index];
    final product = item.product;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
          child: product.imageUrl.startsWith('http')
              ? Image.network(product.imageUrl, width: 100, height: 100, fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.image, size: 50, color: Colors.grey))
              : Image.asset(product.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Text(product.name,
                      style: AppTextStyle.withColour(
                          AppTextStyle.bodyLarge, Theme.of(context).textTheme.bodyLarge!.color!),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                IconButton(
                  onPressed: () => _showDeleteDialog(context, cart, index),
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                ),
              ]),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('LKR ${product.price.toStringAsFixed(2)}',
                    style: AppTextStyle.withColour(
                        AppTextStyle.h3, Theme.of(context).primaryColor)),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(children: [
                    IconButton(
                      onPressed: () => cart.decreaseQuantity(index),
                      icon: Icon(Icons.remove, size: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    Text('${item.quantity}',
                        style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                            Theme.of(context).textTheme.bodyLarge!.color!)),
                    IconButton(
                      onPressed: () => cart.increaseQuantity(index),
                      icon: Icon(Icons.add, size: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ]),
                ),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }

  void _showDeleteDialog(BuildContext context, CartController cart, int index) {
    Get.dialog(AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Remove Item'),
      content: const Text('Are you sure you want to remove this item from your cart?'),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            cart.removeFromCart(index);
            Get.back();
          },
          child: const Text('Remove', style: TextStyle(color: Colors.red)),
        ),
      ],
    ));
  }

  Widget _buildCartSummary(BuildContext context, CartController cart) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Delivery', style: AppTextStyle.withColour(
              AppTextStyle.bodySmall, Theme.of(context).textTheme.bodySmall!.color!)),
          Text(cart.deliveryCharge == 0 ? 'FREE' : 'LKR ${cart.deliveryCharge.toStringAsFixed(2)}',
              style: AppTextStyle.withColour(AppTextStyle.bodySmall, Colors.green)),
        ]),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total (${cart.totalItems} items)',
              style: AppTextStyle.withColour(
                  AppTextStyle.bodySmall, Theme.of(context).textTheme.bodySmall!.color!)),
          Text('LKR ${cart.grandTotal.toStringAsFixed(2)}',
              style: AppTextStyle.withColour(AppTextStyle.h2, Theme.of(context).primaryColor)),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => CheckoutScreen()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Proceed to Checkout',
                style: AppTextStyle.withColour(AppTextStyle.buttonMedium, Colors.white)),
          ),
        ),
      ]),
    );
  }
}
