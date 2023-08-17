import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../model/entities/sample/timeline/post.dart';
import '../../../../../utils/vibration.dart';
import '../enum/menu_result_type.dart';

class TileMenu extends StatelessWidget {
  const TileMenu({
    required this.data,
    required this.isMyData,
    required this.onTapMenu,
    super.key,
  });

  final Post data;
  final bool isMyData;
  final void Function(MenuResultType) onTapMenu;

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
          final result = await showModalActionSheet<MenuResultType>(
            context: context,
            actions: [
              SheetAction<MenuResultType>(
                label: MenuResultType.share.label,
                key: MenuResultType.share,
                icon: Icons.share,
              ),
              SheetAction<MenuResultType>(
                label: MenuResultType.copy.label,
                key: MenuResultType.copy,
                icon: Icons.check,
              ),
              if (!isMyData) ...[
                SheetAction<MenuResultType>(
                  label: MenuResultType.issueReport.label,
                  key: MenuResultType.issueReport,
                  icon: Icons.report_sharp,
                ),
                SheetAction<MenuResultType>(
                  label: MenuResultType.mute.label,
                  key: MenuResultType.mute,
                  icon: Icons.back_hand,
                ),
                SheetAction<MenuResultType>(
                  label: MenuResultType.block.label,
                  key: MenuResultType.block,
                  icon: Icons.block,
                ),
              ],
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
