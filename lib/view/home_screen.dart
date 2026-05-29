import 'package:fashion_store_app/controllers/theme_controller.dart';
import 'package:fashion_store_app/features/notifications/view/notifications_screen.dart';
import 'package:fashion_store_app/view/all_product_screen.dart';
import 'package:fashion_store_app/view/cart_screen.dart';
import 'package:fashion_store_app/view/widget/category_chips.dart';
import 'package:fashion_store_app/view/widget/custom_search_bar.dart';
import 'package:fashion_store_app/view/widget/product_grid.dart';
import 'package:fashion_store_app/view/widget/sale_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //header section
            Container(
            color:const Color.fromARGB(255, 20, 20, 20), 
            padding: const EdgeInsets.all(16),
            child: Row(
            children: [
            CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
             ),
           const SizedBox(width: 12),

           Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hello Kalindu,',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            'Good Morning!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ],
      ),

      const Spacer(),

      // notification
      IconButton(
        onPressed: () => Get.to(() => NotificationsScreen()),
        icon: const Icon(Icons.notifications_outlined, color: Colors.white),
      ),

      // cart
      IconButton(
        onPressed: () => Get.to(() => const CartScreen()),
        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
      ),

      // theme toggle
      GetBuilder<ThemeController>(
        builder: (controller) => IconButton(
          onPressed: () => controller.toggleTheme(),
          icon: Icon(
            controller.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode,
            color: const Color(0xFFD4AF37), 
                ),
                ),
                ),
              ],
              ),
            ),
            //search bar
            const CustomSearchBar(),

            //category 
            const CategoryChips(),

            //sale banner
            const SaleBanner(),

            //popular products
             Padding(padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Popular Product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const AllProductScreen()), 
                  child:Text('See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  ),
                ),
              ],
            ),
            ),

            //product grid
            const Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}