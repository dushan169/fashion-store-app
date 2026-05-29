import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/filter_bottom_sheet.dart';
import 'package:fashion_store_app/view/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
          color:  Theme.of(context).primaryColor,
        ),
        title: Text(
          'All Products',
          style: AppTextStyle.withColour(
            AppTextStyle.h3,
             Colors.white,
          ),
        ),
        actions: [
          //search icon
           IconButton(
            onPressed: () {},
            icon:  Icon(Icons.search,
            color:  Colors.white,
             ),
          ),
          // filter icon
           IconButton(
            onPressed: ()  => FilterBottomSheet.show(context),
            icon:  Icon(Icons.filter_list,
            color:  Colors.white,
             ),
           ),
          
          
        ],
      ),
      body: const ProductGrid(),
    );
  }
}