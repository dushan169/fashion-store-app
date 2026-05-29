import 'package:fashion_store_app/features/notifications/models/notifications_type.dart';
import 'package:fashion_store_app/features/notifications/repositories/notification_repository.dart';
import 'package:fashion_store_app/features/notifications/utils/notification_utils.dart';
import 'package:fashion_store_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationRepository _repository = NotificationRepository();
   NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = _repository.getNotifications();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,),
            ),
        title: Text('Notifications',
        style: AppTextStyle.withColour(
          AppTextStyle.h3, 
          Theme.of(context).primaryColor),

        ),
        actions: [
          TextButton(onPressed: () {}, 
          child: Text(
            'Mark as all read',
            style: AppTextStyle.withColour(
              AppTextStyle.bodySmall,
              Theme.of(context).primaryColor),
          ))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) =>_buildNotificationCard(
        context,
        notifications[index],
      ),
      ),
    );
  }
  Widget _buildNotificationCard(BuildContext context, NotificationItem notification){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: notification.isRead?
        Theme.of(context).cardColor
        : Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: isDark?
          Colors.black.withOpacity(0.2)
          :Colors.white.withOpacity(0.1)
        ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: NotificationUtils.getIconBackgroundColor(
              context, 
              notification.type),
              shape: BoxShape.circle,
          ),
          child: Icon(NotificationUtils.getNotificationIcon(notification.type),
          color: NotificationUtils.getIconColor(context, notification.type),
          ),
        ),
        title: Text(
          notification.title,
          style: AppTextStyle.withColour(
            AppTextStyle.bodyMedium, 
            Theme.of(context).textTheme.bodyMedium!.color!
            ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.message,
            style: AppTextStyle.withColour(
              AppTextStyle.bodySmall, 
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}