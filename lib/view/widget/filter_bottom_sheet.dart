import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class FilterBottomSheet {
  static void show(BuildContext context){
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
          ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context,setState) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Products',
                    style: AppTextStyle.withColour(
                      AppTextStyle.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close,
                  color: isDark ? Colors.white : Colors.black,
                  ),
                  
                ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Price Range',
              style: AppTextStyle.withColour(
                AppTextStyle.bodyLarge,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Min',
                        prefixText: '\$',
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12)),
                            borderSide: BorderSide(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!
                            ),
                        ),
                       ),
                       keyboardType: TextInputType.number,
                    ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Max',
                        prefixText: '\$',
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12)),
                            borderSide: BorderSide(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!
                            ),
                        ),
                       ),
                       keyboardType: TextInputType.number,
                    ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Categories',
              style: AppTextStyle.withColour(
                AppTextStyle.bodyLarge,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
              ),
               const SizedBox(height: 16),
               Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'All',
                  'Outfits',
                  'Underware',
                  'Wearables',
                  'Accessories',
                ].map((Category) => FilterChip(
                  label: Text(Category),
                  selected: Category == 'All',
                  onSelected: (selected){
                    // Handle category selection
                  },
                  backgroundColor: Theme.of(context).cardColor,
                  selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  labelStyle: AppTextStyle.withColour(AppTextStyle.bodyMedium,
                  Category == 'All' 
                  ? Theme.of(context).primaryColor 
                  : Theme.of(context).textTheme.bodyLarge!.color!)
                ),).toList(),
               ),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Apply Filters',
                  style: AppTextStyle.withColour(
                    AppTextStyle.buttonMedium,
                    Colors.white,
                  ),
                  ),
                ),),
            ],
          ),
        ),
        ),
    );
  }
}