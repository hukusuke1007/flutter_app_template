import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageViewerHeader extends HookConsumerWidget {
  const ImageViewerHeader({
    this.onMenuSelected,
    super.key,
  });

  final void Function(int)? onMenuSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    const topBarHeight = 100.0;
    return Container(
      color: Colors.black.withOpacity(0.4),
      height: topBarHeight,
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          SizedBox(
            height: topBarHeight - statusBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.9),
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                if (onMenuSelected != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: PopupMenuButton<int>(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      itemBuilder: (BuildContext context) {
                        final list = ['写真を保存する'];
                        return List.generate(
                          list.length,
                          (index) => PopupMenuItem<int>(
                            value: index,
                            child: Text(list[index]),
                          ),
                        );
                      },
                      onSelected: onMenuSelected,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
