import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

RefreshController useRefreshController() {
  return useState(RefreshController()).value;
}
