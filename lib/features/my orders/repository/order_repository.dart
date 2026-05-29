import 'package:fashion_store_app/features/my%20orders/models/order.dart';
class OrderRepository {
  List<Order> getOrders(){
    return[
      Order(
        OrderNumber: '13245', 
        itemCount: 2, 
        totalAmount: 2658.50, 
        status: OrderStatus.active, 
        imageUrl: 'assets/images/dress (2).jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours:2)),
      ),
       Order(
        OrderNumber: '438565', 
        itemCount: 1, 
        totalAmount: 4334.9, 
        status: OrderStatus.cancelled, 
        imageUrl: 'assets/images/dress (1).jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours:1)),
      ),
       Order(
        OrderNumber: '322445', 
        itemCount: 2, 
        totalAmount: 546.3, 
        status: OrderStatus.completed, 
        imageUrl: 'assets/images/dress (3).jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours:4)),
      ),
       Order(
        OrderNumber: '234720', 
        itemCount: 3, 
        totalAmount: 4379.9, 
        status: OrderStatus.active, 
        imageUrl: 'assets/images/dress (4).jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours:7)),
      ),
    ];
  }
  List<Order>getOrderByStatus(OrderStatus status){
    return getOrders().where((order) => order.status == status).toList();
  }
}