import 'package:fashion_store_app/features/my%20orders/models/order.dart';
import 'package:fashion_store_app/features/my%20orders/repository/order_repository.dart';
import 'package:fashion_store_app/features/my%20orders/view/widgets/order_card.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MyOrdersScreens extends StatelessWidget {
  final OrderRepository _repository =OrderRepository();
  MyOrdersScreens({super.key});

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.black,
         leading: IconButton(
          onPressed:() =>Get.back(), 
          icon: Icon(Icons.arrow_back_ios,
         color:  Theme.of(context).primaryColor,
          ),
          ),
        title: Text(
          'My Orders',
          style: AppTextStyle.withColour(
            AppTextStyle.h3, 
            Theme.of(context).primaryColor
          ),
        ),
        bottom: TabBar(
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: isDark? Colors.grey[400] :Colors.grey[600],
          indicatorColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body:TabBarView(
        children: [
          _buildOrderList(context, OrderStatus.active),
          _buildOrderList(context, OrderStatus.completed),
          _buildOrderList(context, OrderStatus.cancelled),
        ])
      ),
    );
  }
  Widget _buildOrderList(BuildContext context,OrderStatus status){
    final orders = _repository.getOrderByStatus(status);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount:orders.length,
     itemBuilder: (context, index) {
  final order = orders[index];
  return OrderCard(                // ✅ Complete
    order: order,
    onViewDetails: () { },
  );
     }
  );
    
  }
}