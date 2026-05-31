import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_store_app/features/my%20orders/models/order.dart' as app_order;

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> placeOrder(app_order.Order order) async {
    try {
      final docRef = await _firestore.collection('orders').add(order.toFirestore());
      return docRef.id;
    } catch (e) {
      return null;
    }
  }

  Stream<List<app_order.Order>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => app_order.Order.fromFirestore(d)).toList());
  }

  Stream<List<app_order.Order>> getOrdersByStatus(String userId, app_order.OrderStatus status) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: status.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => app_order.Order.fromFirestore(d)).toList());
  }

  // Keep old sync method for backward compat - returns empty list
  List<app_order.Order> getOrders() => [];
  List<app_order.Order> getOrderByStatus(app_order.OrderStatus status) => [];
  Future<bool> updateOrderStatus(String orderId, app_order.OrderStatus status) async {
  try {
    await _firestore
        .collection('orders')
        .doc(orderId)
        .update({'status': status.name});
    return true;
  } catch (e) {
    return false;
  }
  }
}
