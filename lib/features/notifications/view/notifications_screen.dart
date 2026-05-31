import 'package:fashion_store_app/controllers/notification_controller.dart';
import 'package:fashion_store_app/features/notifications/models/notifications_type.dart';
import 'package:fashion_store_app/features/notifications/repositories/notification_repository.dart';
import 'package:fashion_store_app/features/notifications/utils/notification_utils.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationRepository _repository = NotificationRepository();
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();
    final staticNotifications = _repository.getNotifications();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor),
        ),
        title: Text('Notifications',
            style: AppTextStyle.withColour(
                AppTextStyle.h3, Theme.of(context).primaryColor)),
        actions: [
          TextButton(
            onPressed: () {
              notificationController.notifications.clear();
              Get.snackbar('Cleared', 'All notifications have been cleared.');
            },
            child: Text('Clear all',
                style: AppTextStyle.withColour(
                    AppTextStyle.bodySmall, Theme.of(context).primaryColor)),
          ),
        ],
      ),
      body: Obx(() {
        final fcmNotifications = notificationController.notifications;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // FCM notifications
            if (fcmNotifications.isNotEmpty) ...[
              Text('New',
                  style: AppTextStyle.withColour(AppTextStyle.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!)),
              const SizedBox(height: 8),
              ...fcmNotifications.map((n) => _buildFCMCard(context, n)),
              const SizedBox(height: 16),
            ],

            // Static notifications
            Text('Earlier',
                style: AppTextStyle.withColour(AppTextStyle.h3,
                    Theme.of(context).textTheme.bodyLarge!.color!)),
            const SizedBox(height: 8),
            ...staticNotifications.map(
                (n) => _buildNotificationCard(context, n)),
          ],
        );
      }),
    );
  }

  Widget _buildFCMCard(BuildContext context, Map<String, dynamic> notification) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.notifications_active,
              color: Theme.of(context).primaryColor),
        ),
        title: Text(notification['title'],
            style: AppTextStyle.withColour(AppTextStyle.bodyMedium,
                Theme.of(context).textTheme.bodyLarge!.color!)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification['message'],
                style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!)),
            const SizedBox(height: 4),
            Text(notification['time'],
                style: AppTextStyle.withColour(
                    AppTextStyle.bodySmall, Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, NotificationItem notification) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: NotificationUtils.getIconBackgroundColor(
                context, notification.type),
            shape: BoxShape.circle,
          ),
          child: Icon(
              NotificationUtils.getNotificationIcon(notification.type),
              color:
                  NotificationUtils.getIconColor(context, notification.type)),
        ),
        title: Text(notification.title,
            style: AppTextStyle.withColour(AppTextStyle.bodyMedium,
                Theme.of(context).textTheme.bodyLarge!.color!)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.message,
                style: AppTextStyle.withColour(AppTextStyle.bodySmall,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!)),
            const SizedBox(height: 4),
            Text(notification.time,
                style: AppTextStyle.withColour(
                    AppTextStyle.bodySmall,
                    isDark ? Colors.grey[500]! : Colors.grey[400]!)),
          ],
        ),
      ),
    );
  }
}