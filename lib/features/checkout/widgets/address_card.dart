import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class CheckoutAddressCard extends StatelessWidget {
  final String address;
  final VoidCallback onEdit;

  const CheckoutAddressCard({
    super.key,
    required this.address,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
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
          )
        ],
      ),
      child: Row(children: [
        Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Delivery Address',
                style: AppTextStyle.withColour(
                    AppTextStyle.bodyLarge, Theme.of(context).textTheme.bodyLarge!.color!)),
            const SizedBox(height: 4),
            Text(address,
                style: AppTextStyle.withColour(
                    AppTextStyle.bodySmall, isDark ? Colors.grey[400]! : Colors.grey[600]!)),
          ]),
        ),
        IconButton(
          onPressed: onEdit,
          icon: Icon(Icons.edit_outlined, color: Theme.of(context).primaryColor),
        ),
      ]),
    );
  }
}
