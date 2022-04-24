import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/draggable_scrollable_page.dart';
import '../../../widgets/routes/transparent_route.dart';

class DetailPage {
  DetailPage._();
  static void show(
    BuildContext context, {
    required String heroTag,
  }) {
    TransparentRoute.show<void>(
      context,
      DraggableScrollablePage(
        heroTag: heroTag,
        child: const _Body(),
        onDragVertical: (margin, isScaleDown) {
          // logger.info('margin: $margin, isScaleDown: $isScaleDown');
        },
      ),
      rootNavigator: true,
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: context.scaffoldBackgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Image.asset(
                  Assets.images.neko.assetName,
                  fit: BoxFit.fitHeight,
                  height: 300,
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
              'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n',
              style: context.bodyStyle,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
