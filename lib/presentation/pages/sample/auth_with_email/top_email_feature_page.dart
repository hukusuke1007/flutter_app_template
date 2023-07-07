import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../main/main_page.dart';
import 'change_email_address_page.dart';
import 'change_email_password_page.dart';
import 'email_verification_page.dart';
import 'reset_email_password_page.dart';
import 'sign_in_with_email_page.dart';
import 'sign_up_with_email_page.dart';

class TopEmailFeaturePage extends HookConsumerWidget {
  const TopEmailFeaturePage({super.key});

  static String get pageName => 'top_email_feature';
  static String get pagePath => '${MainPage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(BuildContext context) {
    context.push(pagePath);
  }

  /// 従来の画面遷移
  static Future<void> showNav1(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => const TopEmailFeaturePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メールアドレス認証のサンプル',
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
              ListTile(
                title: Text(
                  'サインアップ',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  SignUpWithEmailPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'サインイン',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  SignInWithEmailPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'パスワード変更',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  ChangeEmailPasswordPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'パスワードリセット',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  ResetEmailPasswordPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'メールアドレスの変更',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  ChangeEmailAddressPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'メールアドレス本人認証',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  EmailVerificationPage.push(context);
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
