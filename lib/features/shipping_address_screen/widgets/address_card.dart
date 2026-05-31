import 'package:fashion_store_app/features/shipping_address_screen/models/address.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: address.isDefault
            ? Border.all(color: Theme.of(context).primaryColor, width: 1.5)
            : null,
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
      child: Column(children: [
        Row(children: [
          Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(address.label,
                    style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                        Theme.of(context).textTheme.bodyLarge!.color!)),
                if (address.isDefault) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Default',
                        style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                            Theme.of(context).primaryColor)),
                  ),
                ]
              ]),
              const SizedBox(height: 4),
              Text(address.fullDetails,
                  style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!)),
            ]),
          ),
          IconButton(onPressed: onEdit,
              icon: Icon(Icons.edit_outlined, color: Theme.of(context).primaryColor)),
          IconButton(onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent)),
        ]),
      ]),
    );
  }
}
