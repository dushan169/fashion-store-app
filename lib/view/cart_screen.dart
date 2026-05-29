import 'package:fashion_store_app/features/checkout/screens/checkout_screen.dart';
import 'package:fashion_store_app/models/product.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.back(), 
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,
        ),
        ),
        backgroundColor: const Color.fromARGB(230, 20, 20, 20),
        title: Text('My Cart',
        style: AppTextStyle.withColour(AppTextStyle.h3,
         Theme.of(context).primaryColor),),
      ),
  body: Column(children: [
    Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
    itemCount: products.length,
    itemBuilder: (context, index) => _buildCartItem(
      context, 
      products[index],
    ),
  ),
  ),
  _buildCartSummary(context),
  ],
  ),
  );
  }
  

  Widget _buildCartItem(BuildContext context, Product product){

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(  context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2), 
          ),
        ],
      ),
      child: Row(children: [
        //product image
        ClipRRect(
          borderRadius: 
          BorderRadius.horizontal(left: Radius.circular(16)),
          child: Image.asset(
            product.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
         Expanded(
          child: Padding(padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Expanded(child:  Text(
                  product.name,
                  style: AppTextStyle.withColour(
                    AppTextStyle.bodyLarge, 
                    Theme.of(context).textTheme.bodyLarge!.color!,
                     ),
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(onPressed: () => _showDeleteConfirmationDialog(context,product),
                   icon: Icon(Icons.delete_outline, 
                   color: Colors.redAccent,
                   ),
                   ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('LKR ${product.price.toStringAsFixed(2)}',
                  style: AppTextStyle.withColour(AppTextStyle.h3, 
                  Theme.of(context).primaryColor.withOpacity(0.8)),),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){}, 
                        icon: Icon(Icons.remove,
                        size: 20,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                        ),
                        Text('1',
                        style: AppTextStyle.withColour(
                          AppTextStyle.bodyLarge,  
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          ),
                          ),
                          IconButton(onPressed: (){}, 
                        icon: Icon(Icons.add,
                        size: 20,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),),
        )
      ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Product product){
    Get.dialog(AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[400]!.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline,
              color: Colors.red[400],
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text('Remove Item',
          style: AppTextStyle.withColour(
            AppTextStyle.h3,
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),),
           const SizedBox(height: 8),
          Text('Are you sure you want to remove this item from your cart?',
          textAlign: TextAlign.center,
          style: AppTextStyle.withColour(
            AppTextStyle.bodySmall,
            Theme.of(context).brightness == Brightness.dark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          ),
          const SizedBox(height:24),
          Row(
            children: [
              Expanded(child: OutlinedButton(
                onPressed: () => Get.back(),
                style:OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color:Theme.of(context).primaryColor.withOpacity(0.8), 
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              child: Text('Cancel',
              style: AppTextStyle.withColour(
                AppTextStyle.bodyMedium,
                Theme.of(context).textTheme.bodyMedium!.color!,
              ),
              ),
          ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  // add removal logic here
                  Get.back();
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              child: Text('Remove',
              style: AppTextStyle.withColour(
                AppTextStyle.bodyMedium,
                Theme.of(context).textTheme.bodyMedium!.color!,
              ),
            ),
          ),
          ),
          ],
          ),
        ],
      ),
    ),
    barrierColor: Colors.black54,
    );
  }

  Widget _buildCartSummary(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:Theme.of( context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, -5), 
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total (4 items)',
              style: AppTextStyle.withColour(
                AppTextStyle.bodySmall,
                Theme.of(context).textTheme.bodySmall!.color!,
              ),
              ),
               Text('LKR 8,950.00',
              style: AppTextStyle.withColour(
                AppTextStyle.h2,
                Theme.of(context).primaryColor,
              ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => CheckoutScreen()), // navigate to checkout screen
            style:ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ), 
            child: Text(
              'Proceed to Checkout',
              style: AppTextStyle.withColour(
                AppTextStyle.buttonMedium, 
                Colors.white),
                ),
            ),
          ),
        ],
      ),
    );
  }
}