import 'package:fashion_store_app/controllers/cart_controller.dart';
import 'package:fashion_store_app/controllers/navigation_controller.dart';
import 'package:fashion_store_app/controllers/notification_controller.dart';
import 'package:fashion_store_app/controllers/order_controller.dart';
import 'package:fashion_store_app/controllers/product_controller.dart';
import 'package:fashion_store_app/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'controllers/theme_controller.dart';
import 'utils/app_themes.dart';
import 'view/splash_screen.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(WishlistController());
  Get.put(OrderController());
  Get.put(NotificationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themecontroller = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VERITAS',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themecontroller.theme,
      home: SplashScreen(),
    );
  }
}
