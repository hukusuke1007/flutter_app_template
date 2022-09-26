import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/use_cases/sample/fetch_enable_screen_reader.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../firestore_counter_page.dart';
import '../local_counter_page.dart';
import 'detail_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static String get pageName => 'home_page';
  static String get pagePath => '/$pageName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final enableScreenReader = ref.watch(fetchEnableScreenReaderProvider);
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
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
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
                padding: const EdgeInsets.symmetric(vertical: 32),
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
                  context.push(LocalCounterPage.pagePath);
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
                  context.push(FirestoreCounterPage.pagePath);
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
