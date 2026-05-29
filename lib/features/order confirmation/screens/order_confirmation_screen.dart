import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmount;
  const OrderConfirmationScreen({super.key, required this.orderNumber, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    final isDark =Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/order_success.json',
              width: 200,
              height: 200,
              repeat: false,
              
              )
          ],
        ),
        )),
    );
  }
}