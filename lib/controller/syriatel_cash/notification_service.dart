// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'online',
        'channelName',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  void showNotification(String message) async {
    try {
      var jsonData = json.decode(message);
      String notificationType = jsonData['type'];
      String notificationMessage = jsonData['message'];

      String notificationTitle;
      String notificationBody;

      switch (notificationType) {
        case 'offer':
          notificationTitle = 'New Offer !';
          notificationBody = notificationMessage;
          break;
        case 'ice_cream':
          notificationTitle = 'New Ice Cream !';
          notificationBody = notificationMessage;
          break;
        default:
          notificationTitle = 'Unknown Notification';
          notificationBody = 'Received unknown message type.';
      }

      await notificationsPlugin.show(
        0,
        notificationTitle,
        notificationBody,
        await notificationDetails(),
      );
    } on FormatException catch (e) {
      print('Error parsing JSON message: $e');
      // Handle JSON parsing errors gracefully (e.g., show a generic notification)
    } catch (e) {
      print('Error showing notification: $e');
      // Handle other notification errors gracefully
    }
  }
}
