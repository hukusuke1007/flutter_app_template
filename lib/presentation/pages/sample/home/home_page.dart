import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/scroll_controller_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../model/use_cases/sample/fetch_enable_screen_reader.dart';
import '../../../../utils/provider.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../sample/timeline/timeline_page.dart';
import '../auth_with_email/top_email_feature_page.dart';
import '../firestore_counter/firestore_counter_page.dart';
import '../local_counter/local_counter_page.dart';
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
