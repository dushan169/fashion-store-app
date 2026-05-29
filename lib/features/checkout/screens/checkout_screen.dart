import 'package:fashion_store_app/features/checkout/widgets/address_card.dart';
import 'package:fashion_store_app/features/checkout/widgets/checkout_bottom_bar.dart';
import 'package:fashion_store_app/features/checkout/widgets/order_summary_card.dart';
import 'package:fashion_store_app/features/checkout/widgets/payment_method_card.dart';
import 'package:fashion_store_app/features/order%20confirmation/screens/order_confirmation_screen.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, 
          color: Theme.of(context).primaryColor
          ),
         ),
        title: Text('Checkout',
        style: AppTextStyle.withColour(
          AppTextStyle.h3, 
          Theme.of(context).primaryColor,),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Shipping Address',),
            const SizedBox(height: 16,),
            AddressCard(),
             const SizedBox(height: 24,),
              _buildSectionTitle(context, 'Payment Mathod',),
              const SizedBox(height: 16,),
              const PaymentMethodCard(),
               const SizedBox(height: 24,),
              _buildSectionTitle(context, 'order Summary',),
              const SizedBox(height: 16,),
              OrderSummaryCard()
              
          ],
        )
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount: 26575.00,
        onPlaceOrder: () {
          //generate a random order number(in backend)
          
          final orderNumber = 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
        
          Get.to(()=>OrderConfirmationScreen(
            orderNumber: orderNumber,
            totalAmount: 25875.55,
          ));
        },
      ),
    );
  }
  Widget _buildSectionTitle(BuildContext context, String title){
    return Text(
      title,
      style: AppTextStyle.withColour(
                AppTextStyle.h3,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
    );
  }
}