import 'package:config_env/domain/repository/notify_service.dart';
import 'package:config_env/feature/navigator/navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'high_priority_channel_food', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        icon: "ic_notification",
        ticker: 'ticker',
    );

const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

const channel = AndroidNotificationChannel("high_priority_channel_food", "your channel name", importance: Importance.max);

class NotifyServiceImp implements NotifyService {
  final messaging = FirebaseMessaging.instance;
  late final NotificationSettings settings;

  @override
  Future init() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    settings = await _requestPermission();

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final status = settings.authorizationStatus;
    if (status == AuthorizationStatus.authorized || status == AuthorizationStatus.provisional) {
      final token = await messaging.getToken();
      print('+++ token $token');
      initPushNotification();
    }
  }

  void _handleMessage(RemoteMessage? message) async {
    if (message?.notification != null) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message?.data}');
      print('Message also contained a notification: ${message!.notification?.title}');

      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
      );
    }
  }

  Future<NotificationSettings> _requestPermission() async {
    return await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
  }

  Future initPushNotification() async {
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  void _onMessageOpenedApp(RemoteMessage? message) {
    print('Message data: ${message?.data}');
    if (message?.notification != null) {
      rootNavigatorKey.currentContext?.goNamed('detail');
      print('Message also contained a notification: ${message!.notification?.title}');
    }
  }

  @override
  Future handleOpenFromTerminal() async {
    rootNavigatorKey.currentContext?.goNamed('detail');
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
