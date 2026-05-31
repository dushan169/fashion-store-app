import 'package:fashion_store_app/controllers/cart_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartController = Get.find<CartController>();

    return Obx(() => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRow(context, 'Subtotal',
              'LKR ${cartController.totalPrice.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildRow(context, 'Delivery',
              cartController.deliveryCharge == 0
                  ? 'Free'
                  : 'LKR ${cartController.deliveryCharge.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _buildRow(context, 'Total',
              'LKR ${cartController.grandTotal.toStringAsFixed(2)}',
              isTotal: true),
        ],
      ),
    ));
  }

  Widget _buildRow(BuildContext context, String label, String value,
      {bool isTotal = false}) {
    final textStyle = isTotal ? AppTextStyle.h3 : AppTextStyle.bodyLarge;
    final color = isTotal
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyLarge!.color!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.withColour(textStyle, color)),
        Text(value, style: AppTextStyle.withColour(textStyle, color)),
      ],
    );
  }
}