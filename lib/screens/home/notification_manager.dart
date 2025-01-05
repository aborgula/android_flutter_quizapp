import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationManager {
  // Initialize notifications
  static Future<void> initializeNotifications() async {
    AwesomeNotifications().initialize(
      null, // Use the default icon
      [
        NotificationChannel(
          channelKey: 'daily_reminder',
          channelName: 'Daily Notifications',
          channelDescription: 'Notifications for daily reminders',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    );

    // Request notification permissions
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
  static Future<void> scheduleTestNotification() async {
    print('notifications');
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'daily_reminder',
        title: 'Test Notification',
        body: 'This is a test notification!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute + 1, // Schedule for one minute later
        second: 0,
        repeats: true,
      ),
    );
  }

  // Schedule daily notification
  static Future<void> scheduleDailyNotification() async {

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'daily_reminder',
        title: 'Daily Reminder',
        body: 'Don\'t forget to check your progress today!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: 19, // 7 PM
        minute: 32,
        second: 0,
        repeats: true,
      ),
    );
  }
}
