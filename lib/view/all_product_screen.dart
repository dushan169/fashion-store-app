import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/filter_bottom_sheet.dart';
import 'package:fashion_store_app/view/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
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
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
        ),
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: (value) => productController.searchProducts(value),
              )
            : Text('All Products',
                style: AppTextStyle.withColour(AppTextStyle.h3, Colors.white)),
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
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => FilterBottomSheet.show(context),
            icon: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}