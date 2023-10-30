enum NotificationChannel {
  general,
}

extension NotificationChannelIdExtension on NotificationChannel {
  String get channelId => name;
  String get channelName {
    switch (this) {
      case NotificationChannel.general:
        return 'お知らせ通知';
    }
  }

  String get channelDescription {
    switch (this) {
      case NotificationChannel.general:
        return 'アプリに関するお知らせを通知します';
    }
  }
}
