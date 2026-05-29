import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

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
            color: isDark ? Colors.black : Colors.grey,
            blurRadius: 8,
            offset: const Offset(0, 2)
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
          children: [
            Icon(Icons.location_on_outlined,
            color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              children: [
                Text('Home',
                style:AppTextStyle.withColour(
                  AppTextStyle.h3,
                  isDark ? Colors.white : Colors.black
                ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No. 25 Main Street, kotapola',
                    style: AppTextStyle.withColour(
                      AppTextStyle.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey
                    ),
                  )
              ],
            ),
            ),
          ],
         )
        ],
      ),
    );
  }
}