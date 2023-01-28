import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';

class IdentificationEmailPage extends HookConsumerWidget {
  const IdentificationEmailPage({super.key});

  static String get pageName => 'identification_email';
  static String get pagePath => '/$pageName';

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute(
        builder: (_) => const IdentificationEmailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メールアドレス本人確認',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              ///
            ],
          ),
        ),
      ),
    );
  }
}
