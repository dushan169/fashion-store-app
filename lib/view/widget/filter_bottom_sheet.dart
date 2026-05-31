import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet {
  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productController = Get.find<ProductController>();
    final minController = TextEditingController();
    final maxController = TextEditingController();
    String selectedCategory = productController.selectedCategory.value;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filter Products',
                      style: AppTextStyle.withColour(AppTextStyle.h3,
                          Theme.of(context).textTheme.bodyLarge!.color!)),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Price Range',
                  style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                      Theme.of(context).textTheme.bodyLarge!.color!)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minController,
                      decoration: InputDecoration(
                        hintText: 'Min',
                        prefixText: 'LKR ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDark
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: maxController,
                      decoration: InputDecoration(
                        hintText: 'Max',
                        prefixText: 'LKR ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDark
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Categories',
                  style: AppTextStyle.withColour(AppTextStyle.bodyLarge,
                      Theme.of(context).textTheme.bodyLarge!.color!)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['All', ...productController.categories]
                    .map((category) => FilterChip(
                          label: Text(category),
                          selected: category == selectedCategory,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          backgroundColor: Theme.of(context).cardColor,
                          selectedColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.2),
                          labelStyle: AppTextStyle.withColour(
                              AppTextStyle.bodyMedium,
                              category == selectedCategory
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        minController.clear();
                        maxController.clear();
                        setState(() => selectedCategory = 'All');
                        productController.selectCategory('All');
                        productController.searchProducts('');
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                      child: Text('Reset',
                          style: AppTextStyle.withColour(
                              AppTextStyle.buttonMedium,
                              Theme.of(context).primaryColor)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        productController.selectCategory(selectedCategory);
                        final min = double.tryParse(minController.text);
                        final max = double.tryParse(maxController.text);
                        productController.filterByPrice(min, max);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Apply Filters',
                          style: AppTextStyle.withColour(
                              AppTextStyle.buttonMedium, Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}