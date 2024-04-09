import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

class NotificationHandler {
  static final NotificationHandler _notificationHandler = NotificationHandler._internal();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late BuildContext context;
  late AndroidNotificationDetails androidNotificationDetails;

  factory NotificationHandler() {
    return _notificationHandler;
  }

  NotificationHandler._internal();

  Future<void> init() async {
    tz.initializeTimeZones();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notif_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    androidNotificationDetails = const AndroidNotificationDetails(
        'praktitask', 'praktitask_notification',
        channelDescription: 'For Reminder Notification',
        importance: Importance.max,
        priority: Priority.high);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // context.go("/home");
  }

  void createNotification() async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  void createScheduleNotification(DateTime date) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'PraktiTask Here...!',
        'Dont forget your to-do list, click here..',
        tz.TZDateTime.from(date, tz.local),
        NotificationDetails(android: androidNotificationDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
}
