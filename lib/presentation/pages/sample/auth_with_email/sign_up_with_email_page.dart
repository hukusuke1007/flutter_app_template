import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';

class SignUpWithEmailPage extends HookConsumerWidget {
  const SignUpWithEmailPage({super.key});

  static String get pageName => 'sign_up_with_email';
  static String get pagePath => '/$pageName';

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute(
        builder: (_) => const SignUpWithEmailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'サインアップ',
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
