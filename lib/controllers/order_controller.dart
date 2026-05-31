import 'package:fashion_store_app/features/my%20orders/models/order.dart' as app_order;
import 'package:fashion_store_app/features/my%20orders/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:fashion_store_app/controllers/notification_controller.dart';

class OrderController extends GetxController {
  final OrderRepository _repository = OrderRepository();
  final RxBool isLoading = false.obs;
  Stream<List<app_order.Order>> getUserOrders(String userId) {
    return _repository.getUserOrders(userId);
  }

  Stream<List<app_order.Order>> getOrdersByStatus(
      String userId, app_order.OrderStatus status) {
    return _repository.getOrdersByStatus(userId, status);
  }

  Future<String?> placeOrder({
    required String userId,
    required String deliveryAddress,
    required List<app_order.OrderItem> items,
    required double totalPrice,
    required double deliveryCharge,
  }) async {
    isLoading.value = true;
    try {
      if (userId.isEmpty) {
        Get.snackbar('Error', 'Please login first!');
        return null;
      }

      if (items.isEmpty) {
        Get.snackbar('Error', 'Cart is empty!');
        return null;
      }

      final orderNumber =
          'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      final order = app_order.Order(
        orderId: '',
        userId: userId,
        orderNumber: orderNumber,
        items: items,
        totalAmount: totalPrice,
        deliveryCharge: deliveryCharge,
        status: app_order.OrderStatus.active,
        deliveryAddress: deliveryAddress,
        orderDate: DateTime.now(),
      );

      final orderId = await _repository.placeOrder(order);
      if (orderId != null) {
        Get.snackbar('Success', 'Order placed successfully!');
        Get.find<NotificationController>().addNotification(
    'Order Placed! 🛍️',
    'Your order $orderNumber has been placed successfully!',
        );
        return orderNumber;
      }
      Get.snackbar('Error', 'Failed to place order!');
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateOrderStatus(String orderId, app_order.OrderStatus status) async {
    return await _repository.updateOrderStatus(orderId, status);
  }
}
