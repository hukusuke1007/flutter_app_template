import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrappedNotificationListener extends StatefulWidget {
  const WrappedNotificationListener({
    required this.child,
    this.isBounce = true,
    this.onLoadMore,
    super.key,
  });

  final Widget child;
  final bool isBounce;
  final VoidCallback? onLoadMore;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<WrappedNotificationListener> {
  bool _isLoadMore = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        final offset = scrollInfo.metrics.pixels;
        final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
        final exist = maxScrollExtent != 0 && offset != 0;
        if (!exist) {
          return true;
        }
        // print('$customPixel ${scrollInfo.metrics.maxScrollExtent}');

        if (widget.isBounce) {
          if (offset > maxScrollExtent && !_isLoadMore) {
            _isLoadMore = true;
            if (widget.onLoadMore != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onLoadMore!();
              });
            }
          } else if (_isLoadMore && offset <= maxScrollExtent) {
            _isLoadMore = false;
          }

          return true;
        }

        if (offset >= maxScrollExtent && !_isLoadMore) {
          _isLoadMore = true;
          if (widget.onLoadMore != null) {
            //widget.onLoadMore!();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onLoadMore!();
            });
          }
        } else if (_isLoadMore && offset < maxScrollExtent) {
          _isLoadMore = false;
        }

        return true;
      },
      child: widget.child,
    );
  }
}
