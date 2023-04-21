import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../model/use_cases/sample/auth/email/send_password_reset_email.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../custom_hooks/use_form_field_state_key.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../../../widgets/show_indicator.dart';
import 'top_email_feature_page.dart';
import 'widgets/email_text_field.dart';

class ResetEmailPasswordPage extends HookConsumerWidget {
  const ResetEmailPasswordPage({super.key});

  static String get pageName => 'reset_email_password';
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
        builder: (_) => const ResetEmailPasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final emailFormFieldKey = useFormFieldStateKey();

    final focusNode = useFocusNode();

    useEffectOnce(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        /// フォーカスを当ててキーボード表示
        focusNode.requestFocus();
      });
      return null;
    });

    return GestureDetector(
      onTap: context.hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'パスワードリセット',
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
                /// メールアドレス
                EmailTextField(
                  textFormFieldKey: emailFormFieldKey,
                  focusNode: focusNode,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  hintText: 'メールアドレスを入力',
                ),
                Text(
                  '登録済みのメールアドレスに\nパスワード再発行の案内を送ります',
                  style: context.bodyStyle,
                  textAlign: TextAlign.center,
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
                '送信する',
                style: context.bodyStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () async {
              final isValidEmail =
                  emailFormFieldKey.currentState?.validate() ?? false;

              if (!isValidEmail) {
                logger.info('invalid input data');
                return;
              }
              final email = emailFormFieldKey.currentState?.value;

              if (email == null) {
                return;
              }

              try {
                showIndicator(context);
                await ref.read(sendPasswordResetEmailProvider)(email);
                dismissIndicator(context);
                await showOkAlertDialog(
                  context: context,
                  title: '案内をメールアドレスへ送信しました',
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
      ),
    );
  }
}
