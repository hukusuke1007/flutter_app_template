import 'package:flutter/material.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/draggable_scrollable_page.dart';
import '../../../widgets/routes/transparent_route.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
  });

  static String get pageName => 'detail';
  static String get pagePath => '/$pageName';

  static Future<void> show(
    BuildContext context, {
    required String heroTag,
  }) =>
      TransparentRoute.show<void>(
        context,
        DraggableScrollablePage(
          heroTag: heroTag,
          pageBuilder: (_) => const DetailPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              Image.asset(
                Assets.images.neko.path,
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
              ),
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
    );
  }
}
