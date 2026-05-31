import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/features/shipping_address_screen/models/address.dart';
import 'package:fashion_store_app/features/shipping_address_screen/repositories/address_repository.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressCard extends StatelessWidget {
  final VoidCallback? onTap;
  const AddressCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authController = Get.find<AuthController>();
    final repository = AddressRepository();

    return StreamBuilder<List<Address>>(
      stream: repository.getUserAddresses(authController.userId ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final addresses = snapshot.data ?? [];
        final address = addresses.isEmpty ? null : addresses.first;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: address == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('No address added',
                                style: AppTextStyle.withColour(
                                    AppTextStyle.bodyMedium,
                                    isDark ? Colors.grey[400]! : Colors.grey)),
                            Text('Tap to add address',
                                style: AppTextStyle.withColour(
                                    AppTextStyle.bodySmall,
                                    Theme.of(context).primaryColor)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(address.label,
                                style: AppTextStyle.withColour(AppTextStyle.h3,
                                    isDark ? Colors.white : Colors.black)),
                            const SizedBox(height: 4),
                            Text(address.fullAddress,
                                style: AppTextStyle.withColour(
                                    AppTextStyle.bodySmall,
                                    isDark ? Colors.grey[400]! : Colors.grey)),
                            Text('${address.city}, ${address.state}',
                                style: AppTextStyle.withColour(
                                    AppTextStyle.bodySmall,
                                    isDark ? Colors.grey[400]! : Colors.grey)),
                          ],
                        ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600]),
              ],
            ),
          ),
        );
      },
    );
  }
}