import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../model/use_cases/sample/auth/email/fetch_email.dart';
import '../../../../model/use_cases/sample/auth/email/fetch_email_verified.dart';
import '../../../../model/use_cases/sample/auth/email/send_email_verification.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../../../widgets/show_indicator.dart';
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
        RoundedButton(
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
          onTap: () async {
            try {
              showIndicator(context);
              await ref.read(sendEmailVerificationProvider)();
              dismissIndicator(context);
              await showOkAlertDialog(
                context: context,
                title: '確認用メールを送信しました',
              );
              context.pop();
            } on Exception catch (e) {
              dismissIndicator(context);
              unawaited(
                showOkAlertDialog(
                  context: context,
                  title: 'エラー',
                  message: e.errorMessage,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
