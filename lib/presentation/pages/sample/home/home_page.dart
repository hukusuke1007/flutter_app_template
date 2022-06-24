import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../firestore_counter_page.dart';
import '../local_counter_page.dart';
import 'detail_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
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
                      Assets.images.neko.assetName,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
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
                  LocalCounterPage.show(context);
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
                  FirestoreCounterPage.show(context);
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
