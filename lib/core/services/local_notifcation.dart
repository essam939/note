import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notes/modules/todo/presintaion/screens/home_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late AndroidInitializationSettings androidInitializationSettings;
  late DarwinInitializationSettings darwinInitializationSettings;
  late InitializationSettings initializationSettings;
  BuildContext context;

  LocalNotificationServices({required this.context}) {
    initializing();
  }

  void initializing() async {
    androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    darwinInitializationSettings = DarwinInitializationSettings();
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:onSelectNotification ,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  void onSelectNotification(NotificationResponse? payload) {
    if (payload != null) {
      // Handle payload data if needed
    }

    // Navigate to the HomeScreen when the notification is tapped
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  Future<void> showNotificationSchedule({
    int? id,
    String? title,
    String? body,
    required DateTime scheduledTime,
  }) async {
    if (id == null || title == null || body == null) {
      // Handle the case when id, title, or body is null
      return;
    }

    tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true, // Required to work in the background
      androidScheduleMode: AndroidScheduleMode.alarmClock
    );
  }
}
