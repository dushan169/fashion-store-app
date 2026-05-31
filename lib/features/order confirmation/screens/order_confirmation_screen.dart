import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:fashion_store_app/view/main_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmount;

  const OrderConfirmationScreen({
    super.key,
    required this.orderNumber,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/order_success.json',
                width: 200,
                height: 200,
                repeat: false,
              ),
              const SizedBox(height: 24),
              Text('Order Placed!',
                  style: AppTextStyle.withColour(
                      AppTextStyle.h1, Theme.of(context).textTheme.bodyLarge!.color!)),
              const SizedBox(height: 8),
              Text('Order #$orderNumber',
                  style: AppTextStyle.withColour(AppTextStyle.bodyMedium, Colors.grey)),
              const SizedBox(height: 8),
              Text('Total: LKR ${totalAmount.toStringAsFixed(2)}',
                  style: AppTextStyle.withColour(
                      AppTextStyle.h3, Theme.of(context).primaryColor)),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const MainScreen()),
                  child: const Text('Continue Shopping'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
