import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../model/entities/sample/timeline/post.dart';
import '../../../../../utils/vibration.dart';

enum TileMenuResult {
  share,
  copy,
  issueReport,
}

class TileMenu extends StatelessWidget {
  const TileMenu({
    required this.data,
    required this.onTapMenu,
    super.key,
  });

  final Post data;
  final void Function(TileMenuResult) onTapMenu;

  @override
  Widget build(BuildContext context) {
    const size = 22.0;
    return SizedBox(
      height: size,
      width: size,
      child: IconButton(
        iconSize: size,
        padding: const EdgeInsets.only(left: 4),
        onPressed: () async {
          unawaited(Vibration.select());
          final result = await showModalActionSheet<TileMenuResult>(
            context: context,
            actions: [
              const SheetAction<TileMenuResult>(
                label: 'シェアする',
                key: TileMenuResult.share,
                icon: Icons.share,
              ),
              const SheetAction<TileMenuResult>(
                label: 'コピー',
                key: TileMenuResult.copy,
                icon: Icons.check,
              ),
              const SheetAction<TileMenuResult>(
                label: '通報する',
                key: TileMenuResult.issueReport,
                icon: Icons.report_sharp,
              ),
            ],
            cancelLabel: '閉じる',
          );
          if (result == null) {
            return;
          }
          onTapMenu(result);
        },
        icon: const Icon(
          Icons.more_horiz,
          color: Colors.grey,
        ),
      ),
    );
  }
}
