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
import 'package:fashion_store_app/controllers/auth_controller.dart';



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
            Obx(() {
              final hour = DateTime.now().hour;
              String greeting;
              if (hour < 12) {
                greeting = 'Good Morning!';
              } else if (hour < 17) {
                greeting = 'Good Afternoon!';
              } else if (hour < 21) {
                greeting = 'Good Evening!';
              } else {
                greeting = 'Good Night!';
              }

              final authController = Get.find<AuthController>();
              final photoUrl = authController.userPhotoUrl.value;
              final name = authController.userName.value;

              return Container(
                color: const Color.fromARGB(255, 20, 20, 20),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: photoUrl.isNotEmpty
                          ? NetworkImage(photoUrl)
                          : const AssetImage('assets/images/avatar.jpg') as ImageProvider,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello $name,',
                            style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        Text(greeting,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
  onPressed: () => Get.to(() => NotificationsScreen()),
  icon: const Icon(Icons.notifications_outlined, color: Colors.white),
),
IconButton(
  onPressed: () => Get.to(() => const CartScreen()),
  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
),
GetBuilder<ThemeController>(
  builder: (controller) => IconButton(
    onPressed: () => controller.toggleTheme(),
    icon: Icon(
      controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
      color: const Color(0xFFD4AF37),
    ),
  ),
),
                  ],
                ),
              );
            }),

            //search bar
            const CustomSearchBar(),

            //category 
            const CategoryChips(),

            //sale banner
            const SaleBanner(),

            //popular products
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const AllProductScreen()),
                    child: Text(
                      'See All',
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
