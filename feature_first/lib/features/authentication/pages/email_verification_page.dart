import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/exception_extension.dart';
import '../../../core/res/button_style.dart';
import '../../../core/widgets/show_indicator.dart';
import '../use_cases/fetch_email.dart';
import '../use_cases/fetch_email_verified.dart';
import '../use_cases/send_email_verification.dart';
import 'top_email_feature_page.dart';
import 'widgets/current_email_address_text.dart';

class EmailVerificationPage extends HookConsumerWidget {
  const EmailVerificationPage({super.key});

  static String get pageName => 'email_verification';
  static String get pagePath => '${TopEmailFeaturePage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(BuildContext context) {
    context.push(pagePath);
  }

  /// 従来の画面遷移
  static Future<void> showNav1(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => const EmailVerificationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final currentEmail = ref.watch(fetchEmailProvider);
    final emailVerifiedAsyncValue = ref.watch(fetchEmailVerifiedProvider);
    final emailVerified = emailVerifiedAsyncValue.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メールアドレス本人認証',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 現在のメールアドレス
              CurrentEmailAddressText(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                email: currentEmail ?? '-',
              ),
              if (emailVerified != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    emailVerified
                        ? '本人確認済みです'
                        : 'お使いのメールアドレスの確認が必要です。確認用メールを送信して本人確認をしてください。',
                    style: context.bodyStyle.copyWith(
                      color:
                          emailVerified ? Colors.blueAccent : Colors.redAccent,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FilledButton(
          style: ButtonStyles.normal(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '確認用メールを送信',
              style: context.bodyStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () async {
            try {
              showIndicator(context);
              await ref.read(sendEmailVerificationProvider)();
              if (context.mounted) {
                dismissIndicator(context);
                await showOkAlertDialog(
                  context: context,
                  title: '確認用メールを送信しました',
                );
              }

              if (context.mounted) {
                context.pop();
              }
            } on Exception catch (e) {
              if (context.mounted) {
                dismissIndicator(context);
                showOkAlertDialog(
                  context: context,
                  title: 'エラー',
                  message: e.errorMessage,
                ).ignore();
              }
            }
          },
        ),
      ],
    );
  }
}
