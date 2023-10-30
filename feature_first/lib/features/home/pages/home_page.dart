import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/custom_hooks/use_effect_once.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/scroll_controller_extension.dart';
import '../../../core/res/gen/assets.gen.dart';
import '../../../core/utils/tab_tap_operation_provider.dart';
import '../../authentication/pages/top_email_feature_page.dart';
import '../../firestore_counter/pages/firestore_counter_page.dart';
import '../../local_counter/pages/local_counter_page.dart';
import '../../timeline/pages/timeline_page.dart';
import '../use_cases/fetch_enable_screen_reader.dart';
import 'detail_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static String get pageName => 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final enableScreenReader =
        ref.watch(fetchEnableScreenReaderProvider).asData?.value ?? false;
    final tabTapOperation = ref.watch(tabTapOperationProviders(pageName));

    useEffectOnce(() {
      /// 同じタブが選択された場合、上にスクロールする
      tabTapOperation.addListener((value) {
        if (value == TabTapOperationType.duplication) {
          scrollController.animateToTop();
        }
      });
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ホーム',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  DetailPage.show(
                    context,
                    heroTag: 'neko',
                  );
                },
                child: Center(
                  child: Hero(
                    tag: 'neko',
                    child: Image.asset(
                      Assets.images.neko.path,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16,
                ),
                child: Text(
                  '${() {
                    if (context.isAndroid) {
                      return 'Talkback';
                    } else if (context.isIOS) {
                      return 'VoiceOver';
                    }
                    return '-';
                  }()}: ${enableScreenReader ? 'ON' : 'OFF'}',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(bottom: 8),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'こんにちは'),
                      TextSpan(
                        text: 'こんにちは',
                        style: context.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: 'タップできる',
                        style: context.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint('tap');
                          },
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.check_circle,
                            size: 20,
                            color: Colors.green,
                          ),
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                    ],
                  ),
                  style: context.bodyStyle,
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'ローカルカウンターのサンプル',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  LocalCounterPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'Firestoreカウンターのサンプル',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  FirestoreCounterPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'メールアドレス認証のサンプル',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  TopEmailFeaturePage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'タイムラインのサンプル',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  TimelinePage.push(context);
                },
              ),
              const Divider(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
