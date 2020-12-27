import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  LocalNotificationsService._();
  static final LocalNotificationsService _service =
      LocalNotificationsService._();
  factory LocalNotificationsService.getInstance() => _service;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool _isInitialized = false;
  Future<void> init() async {
    if (_isInitialized) return;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    _isInitialized = true;
  }

  void displayNotification(String title, String body, {String payload}) async {
    if (!_isInitialized) return;
    print("sending notification");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'gratitudeAppChannelId',
            'gratitudeAppChannelName',
            'for sending reminders and sending gratitudes',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
            color: Colors.transparent);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  // deprecated function
  // void scheduleNotification(String title, String body, {String payload}) async {
  //   print("checking if local notifications is initialized");
  //   if (!_isInitialized) return;
  //   print("scheduling notification");
  //   DateTime now = DateTime.now();
  //   DateTime notificationSchedule = DateTime(
  //       now.year, now.month, now.day, now.hour, now.minute, now.second + 15);
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'gratitudeAppChannelId',
  //           'gratitudeAppChannelName',
  //           'for sending reminders and sending gratitudes',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           showWhen: false);
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await _flutterLocalNotificationsPlugin.schedule(
  //     0,
  //     title,
  //     body,
  //     notificationSchedule,
  //     platformChannelSpecifics,
  //     payload: payload,
  //   );
  // }
}
