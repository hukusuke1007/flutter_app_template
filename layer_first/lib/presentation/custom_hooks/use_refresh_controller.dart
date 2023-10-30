import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

RefreshController useRefreshController() {
  return useState(RefreshController()).value;
}
