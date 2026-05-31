import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productController = Get.find<ProductController>();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: (value) => productController.searchProducts(value),
        style: AppTextStyle.withColour(AppTextStyle.bodyMedium,
            Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppTextStyle.withColour(
              AppTextStyle.bodySmall,
              isDark ? Colors.grey[400]! : Colors.grey[600]!),
          prefixIcon: Icon(Icons.search,
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!),
          suffixIcon: Icon(Icons.tune,
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!),
          filled: true,
          fillColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}