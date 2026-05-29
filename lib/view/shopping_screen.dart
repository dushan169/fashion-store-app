import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/widget/category_chips.dart';
import 'package:fashion_store_app/view/widget/filter_bottom_sheet.dart';
import 'package:fashion_store_app/view/widget/product_grid.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Shopping',
        style: AppTextStyle.withColour(AppTextStyle.h3,
         Theme.of(context).primaryColor,
         ),),
        actions: [
          
          //search icon
           IconButton(
            onPressed: () {},
            icon:  Icon(Icons.search,
            color:  Theme.of(context).primaryColor,
             ),
          ),
          // filter icon
           IconButton(
            onPressed: ()  => FilterBottomSheet.show(context),
            icon:  Icon(Icons.filter_list,
            color:  Theme.of(context).primaryColor,
             ),
           ), 
        ],
      ),
      body: const Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 16),
          child: CategoryChips(),
          ),
          SizedBox(height: 16,),
          Expanded(child: ProductGrid(),),
        ],
      ),
    );
  }
}