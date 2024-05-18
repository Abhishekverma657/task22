import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings()
      
    );
     

    _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
    // tz.  DateTime.now();
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'important_notification',
          'Main Channel',
          channelDescription: 'Main channel notifications',
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails()
       
      ),
 
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }
}
