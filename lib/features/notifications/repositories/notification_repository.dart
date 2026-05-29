import 'package:fashion_store_app/features/notifications/models/notifications_type.dart';


class NotificationRepository {
  List<NotificationItem> getNotifications() {
    return  [
      NotificationItem(
        title: 'Order Update',
        message: 'Your order #1234 has been shipped.',
        time: '30 minutes ago',
        type: NotificationType.order,
        isRead: true,
      ),
      NotificationItem(
        title: 'Delivery Scheduled',
        message: 'Your delivery is scheduled for tomorrow.',
       time:'1 hours ago',
        type: NotificationType.delivery,
        isRead: true,
      ),
      NotificationItem(
        title: 'New Promo',
        message: 'Get 20% off on your next purchase!',
        time: '3 hoours ago',
        type: NotificationType.promo,
        isRead: true,
      ),
      NotificationItem(
        title: 'Payment Received',
        message: 'We have received your payment for order #1234.',
        time: '2 minutes ago',
        type: NotificationType.payment,
        isRead: true,
      ),
    ];
  }
}