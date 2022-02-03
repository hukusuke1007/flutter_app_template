import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

final localNotificationRepositoryProvider =
    Provider<LocalNotificationRepository>((ref) {
  return LocalNotificationRepository(FlutterLocalNotificationsPlugin());
});

class LocalNotificationRepository {
  LocalNotificationRepository(this._flutterLocalNotificationsPlugin);

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> configure({
    bool requestAlertPermission = true,
    bool requestSoundPermission = true,
    bool requestBadgePermission = true,
    SelectNotificationCallback? onSelectNotification,
  }) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: requestAlertPermission,
      requestBadgePermission: requestSoundPermission,
      requestSoundPermission: requestBadgePermission,
    );
    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<bool> requestPermission({
    bool sound = true,
    bool alert = true,
    bool badge = true,
  }) async {
    final impl =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!;
    final result = await impl.requestPermissions(
      sound: sound,
      alert: alert,
      badge: badge,
    );
    return result ?? false;
  }

  Future<void> show({
    required String title,
    required String body,
    required int id,
    required String androidChannelId,
    required String androidChannelName,
    required String androidChannelDescription,
    String? payload,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> requestZonedSchedule({
    required String title,
    required String body,
    required tz.TZDateTime tzDateTime,
    DateTimeComponents? dateTimeComponents,
    required int id,
    required String androidChannelId,
    required String androidChannelName,
    required String androidChannelDescription,
    String? payload,
  }) async {
    /// https://pub.dev/packages/flutter_local_notifications#scheduling-a-notification
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      NotificationDetails(android: androidPlatformChannelSpecifics),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true, // 低電力アイドルモードでも通知する設定
      payload: payload,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  Future<void> requestPeriodicallyShow({
    required String title,
    required String body,
    required RepeatInterval interval,
    required int id,
    required String androidChannelId,
    required String androidChannelName,
    required String androidChannelDescription,
    String? payload,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      NotificationDetails(android: androidPlatformChannelSpecifics),
      payload: payload,
      androidAllowWhileIdle: true, // 低電力アイドルモードでも通知する設定
    );
  }

  Future<void> cancel(int id) async {
    return _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAll() async {
    return _flutterLocalNotificationsPlugin.cancelAll();
  }
}
