import 'package:fashion_store_app/controllers/order_controller.dart';
import 'package:fashion_store_app/features/my%20orders/models/order.dart' as app_order;
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  final app_order.Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
        ),
        title: Text('Order Details',
            style: AppTextStyle.withColour(
                AppTextStyle.h3, Theme.of(context).primaryColor)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info
            _buildSection(context, isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow(context, 'Order Number', '#${order.orderNumber}', isDark),
                  const Divider(),
                  _buildRow(context, 'Date',
                      '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}', isDark),
                  const Divider(),
                  _buildRow(context, 'Status', order.statusString.capitalizeFirst!, isDark,
                      valueColor: _getStatusColor(order.statusString)),
                  const Divider(),
                  _buildRow(context, 'Delivery Address', order.deliveryAddress, isDark),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Items
            Text('Items', style: AppTextStyle.withColour(
                AppTextStyle.h3, Theme.of(context).textTheme.bodyLarge!.color!)),
            const SizedBox(height: 8),
            _buildSection(context, isDark,
              child: Column(
                children: order.items.map((item) =>
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: item.imageUrl.startsWith('http')
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) =>
                                            const Icon(Icons.image, color: Colors.grey)),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) =>
                                            const Icon(Icons.image, color: Colors.grey)),
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.productName,
                                    style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                                        Theme.of(context).textTheme.bodyLarge!.color!)),
                                Text('Size: ${item.size} • Qty: ${item.quantity}',
                                    style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                                        isDark ? Colors.grey[400]! : Colors.grey[600]!)),
                              ],
                            ),
                          ),
                          Text('LKR ${(item.price * item.quantity).toStringAsFixed(2)}',
                              style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                                  Theme.of(context).textTheme.bodyLarge!.color!)),
                        ],
                      ),
                      if (order.items.last != item) const Divider(),
                    ],
                  ),
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Price Summary
            Text('Price Summary', style: AppTextStyle.withColour(
                AppTextStyle.h3, Theme.of(context).textTheme.bodyLarge!.color!)),
            const SizedBox(height: 8),
            _buildSection(context, isDark,
              child: Column(
                children: [
                  _buildRow(context, 'Subtotal',
                      'LKR ${order.totalAmount.toStringAsFixed(2)}', isDark),
                  const Divider(),
                  _buildRow(context, 'Delivery',
                      order.deliveryCharge == 0
                          ? 'Free'
                          : 'LKR ${order.deliveryCharge.toStringAsFixed(2)}',
                      isDark),
                  const Divider(),
                  _buildRow(context, 'Total',
                      'LKR ${(order.totalAmount + order.deliveryCharge).toStringAsFixed(2)}',
                      isDark, isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: order.status == app_order.OrderStatus.active
    ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showConfirmDialog(
                    context,
                    'Cancel Order',
                    'Are you sure you want to cancel this order?',
                    () async {
                      final orderController = Get.find<OrderController>();
                      await orderController.updateOrderStatus(
                          order.orderId, app_order.OrderStatus.cancelled);
                      Get.back();
                      Get.snackbar('Order', 'Order cancelled!');
                    },
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: Text('Cancel Order',
                      style: AppTextStyle.withColour(
                          AppTextStyle.buttonMedium, Colors.red)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showConfirmDialog(
                    context,
                    'Complete Order',
                    'Mark this order as completed?',
                    () async {
                      final orderController = Get.find<OrderController>();
                      await orderController.updateOrderStatus(
                          order.orderId, app_order.OrderStatus.completed);
                      Get.back();
                      Get.snackbar('Order', 'Order completed!');
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text('Complete Order',
                      style: AppTextStyle.withColour(
                          AppTextStyle.buttonMedium, Colors.white)),
                ),
              ),
            ],
          ),
        ),
      )
    : null,
    );
  }

  void _showConfirmDialog(
  BuildContext context,
  String title,
  String message,
  VoidCallback onConfirm,
) {
  Get.dialog(AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          Get.back();
          onConfirm();
        },
        child: Text(title,
            style: TextStyle(
              color: title.contains('Cancel') ? Colors.red : Colors.green,
            )),
      ),
    ],
  ));
}

  Widget _buildSection(BuildContext context, bool isDark, {required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  Widget _buildRow(BuildContext context, String label, String value, bool isDark,
      {bool isTotal = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyle.withColour(AppTextStyle.bodyMedium,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: AppTextStyle.withColour(
                    isTotal ? AppTextStyle.h3 : AppTextStyle.bodyMedium,
                    valueColor ??
                        (isTotal
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyLarge!.color!))),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active': return Colors.blue;
      case 'completed': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  
}