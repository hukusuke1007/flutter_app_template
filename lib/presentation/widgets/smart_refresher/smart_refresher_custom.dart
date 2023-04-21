import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SmartRefreshHeader extends StatelessWidget {
  const SmartRefreshHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (context, mode) {
        if (mode == RefreshStatus.idle) {
          return const SizedBox.shrink();
        }
        return const SizedBox(
          height: 55,
          child: Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}

class SmartRefreshFooter extends StatelessWidget {
  const SmartRefreshFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        return SizedBox(
          height: 55,
          child: mode == LoadStatus.idle
              ? const SizedBox.shrink()
              : const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
