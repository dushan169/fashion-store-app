import 'package:fashion_store_app/controllers/auth_controller.dart';
import 'package:fashion_store_app/features/my%20orders/models/order.dart' as app_order;
import 'package:fashion_store_app/features/my%20orders/repository/order_repository.dart';
import 'package:fashion_store_app/features/my%20orders/view/screens/order_details_screen.dart';
import 'package:fashion_store_app/features/my%20orders/view/widgets/order_card.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersScreens extends StatelessWidget {
  final OrderRepository _repository = OrderRepository();
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
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
          ),
          title: Text('My Orders',
              style: AppTextStyle.withColour(AppTextStyle.h3, Theme.of(context).primaryColor)),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(children: [
          _buildOrderList(context, app_order.OrderStatus.active),
          _buildOrderList(context, app_order.OrderStatus.completed),
          _buildOrderList(context, app_order.OrderStatus.cancelled),
        ]),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, app_order.OrderStatus status) {
    final authController = Get.find<AuthController>();
    final userId = authController.userId ?? '';

    return StreamBuilder<List<app_order.Order>>(
      stream: _repository.getOrdersByStatus(userId, status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final orders = snapshot.data ?? [];
        if (orders.isEmpty) {
          return Center(
            child: Text('No ${status.name} orders',
                style: AppTextStyle.withColour(
                    AppTextStyle.bodyMedium, Colors.grey)),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) => OrderCard(
            order: orders[index],
            onViewDetails: ()  => Get.to(() => OrderDetailsScreen(order: orders[index])),
          ),
        );
      },
    );
  }
}
