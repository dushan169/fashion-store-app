import 'package:fashion_store_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find<NavigationController>();

    return Obx(
  () => BottomNavigationBar(
    currentIndex: navigationController.currentIndex.value,
    onTap: (index) => navigationController.changeIndex(index),

    //  FORCE BLACK BACKGROUND
    backgroundColor: const Color.fromARGB(255, 20, 20, 20),

    // CONTROL COLORS MANUALLY
    selectedItemColor: const Color(0xFFD4AF37), // gold
    unselectedItemColor: Colors.grey,

    type: BottomNavigationBarType.fixed,

    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined),
        label: 'Shopping',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Wishlist',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Account',
      ),
    ],
  ),
);

  }
}