import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/controllers/cart_controller.dart';
import 'package:fashion_store_app/controllers/order_controller.dart';
import 'package:fashion_store_app/features/checkout/widgets/checkout_bottom_bar.dart';
import 'package:fashion_store_app/features/checkout/widgets/order_summary_card.dart';
import 'package:fashion_store_app/features/checkout/widgets/payment_method_card.dart';
import 'package:fashion_store_app/features/my%20orders/models/order.dart' as app_order;
import 'package:fashion_store_app/features/order%20confirmation/screens/order_confirmation_screen.dart';
import 'package:fashion_store_app/features/shipping_address_screen/repositories/address_repository.dart';
import 'package:fashion_store_app/features/shipping_address_screen/shipping_address_screen.dart';
import 'package:fashion_store_app/features/widgets/address_card.dart' show AddressCard;
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    _buildSectionTitle(context, 'Shipping Address'),
    TextButton(
      onPressed: () => Get.to(() => ShippingAddressScreen()),
      child: Text('Change',
          style: AppTextStyle.withColour(
              AppTextStyle.bodyMedium,
              Theme.of(context).primaryColor)),
    ),
  ],
),
const SizedBox(height: 16),
AddressCard(
   onTap: () => Get.to(() => ShippingAddressScreen()),
),
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
     
bottomNavigationBar: Obx(() {
  final cartController = Get.find<CartController>();
  return CheckoutBottomBar(
    totalAmount: cartController.grandTotal,
    onPlaceOrder: () async {
      final orderController = Get.find<OrderController>();
      final authController = Get.find<AuthController>();
      final cartController = Get.find<CartController>();
      final addressRepository = AddressRepository();

      final address = await addressRepository
          .getDefaultAddress(authController.userId ?? '');
      final deliveryAddress = address?.fullAddress ?? 'No address';

      final items = cartController.cartItems
          .map((item) => app_order.OrderItem(
                productId: item.product.id,
                productName: item.product.name,
                imageUrl: item.product.imageUrl,
                price: item.product.price,
                quantity: item.quantity,
                size: item.selectedSize,
              ))
          .toList();

      final orderNumber = await orderController.placeOrder(
        userId: authController.userId ?? '',
        deliveryAddress: deliveryAddress,
        items: items,
        totalPrice: cartController.totalPrice,
        deliveryCharge: cartController.deliveryCharge,
      );

      if (orderNumber != null) {
        cartController.clearCart();
        Get.to(() => OrderConfirmationScreen(
          orderNumber: orderNumber,
          totalAmount: cartController.grandTotal,
        ));
      }
    },
  );
}),
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