import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

part 'local_notification_repository.g.dart';

@Riverpod(keepAlive: true)
LocalNotificationRepository localNotificationRepository(Ref ref) {
  return LocalNotificationRepository(FlutterLocalNotificationsPlugin());
}

class LocalNotificationRepository {
  LocalNotificationRepository(this._flutterLocalNotificationsPlugin);

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> configure({
    bool requestAlertPermission = true,
    bool requestSoundPermission = true,
    bool requestBadgePermission = true,
    DidReceiveNotificationResponseCallback? onDidReceiveNotificationResponse,
    DidReceiveBackgroundNotificationResponseCallback?
    onDidReceiveBackgroundNotificationResponse,
  }) async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: requestAlertPermission,
      requestBadgePermission: requestSoundPermission,
      requestSoundPermission: requestBadgePermission,
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  Future<void> createChannel(AndroidNotificationChannel channel) async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<bool> requestPermission({
    bool sound = true,
    bool alert = true,
    bool badge = true,
  }) async {
    final impl = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()!;
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
    Importance importance = Importance.max,
    Priority priority = Priority.high,
    String ticker = 'ticker',
    String? payload,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: importance,
      priority: priority,
      ticker: ticker,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
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
    Importance importance = Importance.max,
    Priority priority = Priority.high,
    String ticker = 'ticker',
    String? payload,
    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle, // 低電力アイドルモードでも通知する設定
  }) async {
    /// https://pub.dev/packages/flutter_local_notifications#scheduling-a-notification
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: importance,
      priority: priority,
      ticker: ticker,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      NotificationDetails(android: androidPlatformChannelSpecifics),
      androidScheduleMode: androidScheduleMode,
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
    Importance importance = Importance.max,
    Priority priority = Priority.high,
    String ticker = 'ticker',
    String? payload,
    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle, // 低電力アイドルモードでも通知する設定
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: importance,
      priority: priority,
      ticker: ticker,
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      NotificationDetails(android: androidPlatformChannelSpecifics),
      payload: payload,
      androidScheduleMode: androidScheduleMode,
    );
  }

  Future<void> cancel(int id) => _flutterLocalNotificationsPlugin.cancel(id);

  Future<void> cancelAll() => _flutterLocalNotificationsPlugin.cancelAll();
}
