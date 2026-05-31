import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    // Permission request
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // FCM Token get කරන්න
    final token = await _messaging.getToken();
    print('FCM Token: $token');

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        notifications.insert(0, {
          'title': message.notification!.title ?? '',
          'message': message.notification!.body ?? '',
          'time': 'Just now',
          'isRead': false,
        });
        Get.snackbar(
          message.notification!.title ?? 'Notification',
          message.notification!.body ?? '',
          duration: const Duration(seconds: 3),
        );
      }
    });

    // Background message tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        notifications.insert(0, {
          'title': message.notification!.title ?? '',
          'message': message.notification!.body ?? '',
          'time': 'Just now',
          'isRead': false,
        });
      }
    });
  }

  void addNotification(String title, String message) {
  notifications.insert(0, {
    'title': title,
    'message': message,
    'time': 'Just now',
    'isRead': false,
  });
  }
}