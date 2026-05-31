import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus { active, completed, cancelled }

class OrderItem {
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  final int quantity;
  final String size;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.size,
  });

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'productName': productName,
        'imageUrl': imageUrl,
        'price': price,
        'quantity': quantity,
        'size': size,
      };

  factory OrderItem.fromMap(Map<String, dynamic> map) => OrderItem(
        productId: map['productId'] ?? '',
        productName: map['productName'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        price: (map['price'] ?? 0).toDouble(),
        quantity: map['quantity'] ?? 1,
        size: map['size'] ?? 'M',
      );
}

class Order {
  final String orderId;
  final String userId;
  final String orderNumber;
  final List<OrderItem> items;
  final double totalAmount;
  final double deliveryCharge;
  final OrderStatus status;
  final String deliveryAddress;
  final DateTime orderDate;

  Order({
    required this.orderId,
    required this.userId,
    required this.orderNumber,
    required this.items,
    required this.totalAmount,
    required this.deliveryCharge,
    required this.status,
    required this.deliveryAddress,
    required this.orderDate,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  String get imageUrl => items.isNotEmpty ? items.first.imageUrl : '';
  String get statusString => status.name;

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'orderNumber': orderNumber,
        'items': items.map((i) => i.toMap()).toList(),
        'totalAmount': totalAmount,
        'deliveryCharge': deliveryCharge,
        'status': status.name,
        'deliveryAddress': deliveryAddress,
        'createdAt': FieldValue.serverTimestamp(),
      };

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      orderId: doc.id,
      userId: data['userId'] ?? '',
      orderNumber: data['orderNumber'] ?? '',
      items: (data['items'] as List<dynamic>? ?? [])
          .map((i) => OrderItem.fromMap(i as Map<String, dynamic>))
          .toList(),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      deliveryCharge: (data['deliveryCharge'] ?? 0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => OrderStatus.active,
      ),
      deliveryAddress: data['deliveryAddress'] ?? '',
      orderDate: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
