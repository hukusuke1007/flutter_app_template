import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../widgets/error_text.dart';
import '../main/main_page.dart';
import 'start_up_controller.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({super.key});

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true)
        .pushReplacement<MaterialPageRoute<dynamic>, void>(
      PageTransition(
        type: PageTransitionType.fade,
        child: const StartUpPage(),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(startUpControllerProvider);

    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(startUpControllerProvider.future);
        if (result == StartUpResultType.forcedVersionUpgrade) {
          // TODO(shohei): 強制バージョンアップのダイアログ出したりする
          return;
        }
        unawaited(MainPage.show(context));
      });
      return null;
    });

    return Scaffold(
      body: Center(
        child: asyncValue.when(
          data: (data) {
            if (data == StartUpResultType.forcedVersionUpgrade) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '最新バージョンがリリースされています\nアップグレードしてください',
                    style: context.bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    child: Text(
                      'アプリストアを確認',
                      style: context.bodyStyle.copyWith(
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: () {
                      // TODO(shohei): アプリストアへ遷移
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
          error: (e, __) {
            final error = e as Exception?;
            final message = 'エラー\n${error?.errorMessage}';
            return ErrorText(
              message: message,
              onRetry: () {
                ref.invalidate(startUpControllerProvider);
              },
            );
          },
          loading: () {
            return const CupertinoActivityIndicator();
          },
        ),
      ),
    );
  }
}
