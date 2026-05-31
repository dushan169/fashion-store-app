import 'package:fashion_store_app/features/my%20orders/models/order.dart' as app_order;
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class OrderCard extends StatelessWidget {
  final app_order.Order order;
  final VoidCallback onViewDetails;

  const OrderCard({
    super.key,
    required this.order,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: order.imageUrl.startsWith('http')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(order.imageUrl, fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              const Icon(Icons.image, color: Colors.grey)),
                    )
                  : const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order #${order.orderNumber}',
                      style: AppTextStyle.withColour(AppTextStyle.h3,
                          Theme.of(context).textTheme.bodyLarge!.color!)),
                  const SizedBox(height: 4),
                  Text(
                    '${order.itemCount} items  •  LKR ${order.totalAmount.toStringAsFixed(2)}',
                    style: AppTextStyle.withColour(AppTextStyle.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!),
                  ),
                  const SizedBox(height: 8),
                  _buildStatusChip(context, order.statusString),
                ],
              ),
            ),
          ]),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
        InkWell(
          onTap: onViewDetails,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('View Details',
                style: AppTextStyle.withColour(
                    AppTextStyle.buttonMedium, Theme.of(context).primaryColor)),
          ),
        )
      ]),
    );
  }

  Widget _buildStatusChip(BuildContext context, String type) {
    Color getStatusColor() {
      switch (type) {
        case 'active': return Colors.blue;
        case 'completed': return Colors.green;
        case 'cancelled': return Colors.red;
        default: return Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: getStatusColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.capitalize!,
        style: AppTextStyle.withColour(AppTextStyle.bodySmall, getStatusColor()),
      ),
    );
  }
}
