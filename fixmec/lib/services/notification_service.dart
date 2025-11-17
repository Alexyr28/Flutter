import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin.initialize(settings);
  }

  static Future<void> requestPermissions() async {
    final android = notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await android?.requestNotificationsPermission();
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    int id = 0,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          "fixmec_channel",
          "FixMec Notifications",
          channelDescription: "Alertas de Mantenimiento",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(id, title, body, notificationDetails);
  }
}
