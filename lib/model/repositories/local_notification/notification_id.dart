import 'dart:math';

final _random = Random();

class NotificationId {
  NotificationId._();
  static int get createNotifyId =>
      _random.nextInt(pow(2, 31).toInt() - 1); // 4バイトの数字からランダムで取得する
}
