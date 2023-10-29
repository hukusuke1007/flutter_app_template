import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  static DateTime nowStartAt({int addDay = 0}) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + addDay);
  }

  String format({
    String pattern = 'yyyy/MM/dd HH:mm:ss',
    String locale = 'ja_JP',
  }) =>
      DateFormat(pattern, locale).format(this);

  DateTime toJst() {
    return toUtc().add(const Duration(hours: 9));
  }

  DateTime toYearMonthDay() {
    final date = DateTime(year, month, day);
    return date.add(date.timeZoneOffset).toUtc();
  }

  String get timelineLabel {
    final now = DateTime.now().toUtc();
    final self = toUtc();
    final difference = now.difference(self);
    final sec = difference.inSeconds;
    if (sec < 0) {
      return format(pattern: 'yyyy.M.d');
    }

    if (sec >= 60 * 60 * 24 * 30) {
      return format(pattern: 'yyyy.M.d');
    } else if (sec >= 60 * 60 * 24) {
      return '${difference.inDays}日前';
    } else if (sec >= 60 * 60) {
      return '${difference.inHours}時間前';
    } else if (sec >= 60) {
      return '${difference.inMinutes}分前';
    } else {
      return '$sec秒前';
    }
  }

  // d1 > d2 => true
  // d1 <= d2 => false
  bool isGreater(DateTime d2) {
    final d1 = this;
    return d1.toUtc().isAfter(d2.toUtc());
  }

  DateTime setHour(
    int hour, [
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  ]) =>
      DateTime(
        year,
        month,
        day,
        hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );

  DateTime get clone => DateTime.fromMicrosecondsSinceEpoch(
        microsecondsSinceEpoch,
        isUtc: isUtc,
      );

  DateTime get startOfDay => clone.setHour(0, 0, 0, 0, 0);

  DateTime get endOfDay => clone.setHour(23, 59, 59, 59, 59);

  /// https://stackoverflow.com/questions/62872349/dart-flutter-get-first-datetime-of-this-week
  /// 週始まり（月）
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1)).startOfDay;

  /// 週終わり（日）
  DateTime get endOfWeek =>
      add(Duration(days: DateTime.daysPerWeek - weekday)).startOfDay;

  /// 月始まり
  DateTime get startOfMonth => DateTime(year, month).startOfDay;

  /// 月終わり
  DateTime get endOfMonth => DateTime(year, month + 1, 0).startOfDay;

  /// 次の月
  DateTime get nextMonth => DateTime(year, month + 1);

  /// 前の日
  DateTime get beforeDay => DateTime(year, month, day - 1).startOfDay;

  /// 次の日
  DateTime get nextDay => DateTime(year, month, day + 1).startOfDay;

  /// 日始まり
  DateTime startAt({int addDay = 0}) => DateTime(year, month, day + addDay);

  /// 同じ日付か確認
  bool isSameDate(DateTime other) {
    final a = toLocal();
    final b = other.toLocal();
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// 同じ年月か確認
  bool isSameMonthLocal(DateTime other) {
    final a = toLocal();
    final b = other.toLocal();
    return a.year == b.year && a.month == b.month;
  }
}
