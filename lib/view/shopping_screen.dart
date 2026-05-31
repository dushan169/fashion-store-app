import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/category_chips.dart';
import 'package:fashion_store_app/view/widget/filter_bottom_sheet.dart';
import 'package:fashion_store_app/view/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  bool _showSearch = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
                onChanged: (value) => productController.searchProducts(value),
              )
            : Text('Shopping',
                style: AppTextStyle.withColour(
                    AppTextStyle.h3, Theme.of(context).primaryColor)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) {
                  _searchController.clear();
                  productController.searchProducts('');
                }
              });
            },
            icon: Icon(
              _showSearch ? Icons.close : Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () => FilterBottomSheet.show(context),
            icon: Icon(Icons.filter_list, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: CategoryChips(),
          ),
          const SizedBox(height: 16),
          Expanded(child: ProductGrid()),
        ],
      ),
    );
  }
}