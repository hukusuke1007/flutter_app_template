import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../model/use_cases/sample/auth/email/change_email_password.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_form_field_state_key.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/show_indicator.dart';
import 'reset_email_password_page.dart';
import 'widgets/forget_password_button.dart';
import 'widgets/passward_text_field.dart';

class ChangeEmailPasswordPage extends HookConsumerWidget {
  const ChangeEmailPasswordPage({super.key});

  static String get pageName => 'change_email_password';
  static String get pagePath => '/$pageName';

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute(
        builder: (_) => const ChangeEmailPasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final oldPasswordFormFieldKey = useFormFieldStateKey();
    final newPasswordFormFieldKey = useFormFieldStateKey();
    return GestureDetector(
      onTap: context.hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'パスワード変更',
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
                /// 現在のパスワード
                PasswordTextField(
                  textFormFieldKey: oldPasswordFormFieldKey,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  hintText: '大文字小文字含む英数字8桁以上',
                  title: '現在のパスワードを入力',
                ),

                /// 変更後パスワード
                PasswordTextField(
                  textFormFieldKey: newPasswordFormFieldKey,
                  padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
                    bottom: 16,
                  ),
                  hintText: '大文字小文字含む英数字8桁以上',
                  title: '変更後のパスワードを入力',
                ),

                /// パスワードを忘れた
                ForgetPasswordButton(
                  onTap: () {
                    ResetEmailPasswordPage.show(context);
                  },
                )
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
                '変更する',
                style: context.bodyStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () async {
              final isValidOldPassword =
                  oldPasswordFormFieldKey.currentState?.validate() ?? false;
              final isValidNewPassword =
                  newPasswordFormFieldKey.currentState?.validate() ?? false;

              if (!isValidOldPassword || !isValidNewPassword) {
                logger.info('invalid input data');
                return;
              }
              final oldPassword = oldPasswordFormFieldKey.currentState?.value;
              final newPassword = newPasswordFormFieldKey.currentState?.value;
              if (oldPassword == null || newPassword == null) {
                return;
              }

              try {
                showIndicator(context);
                await ref.read(changeEmailPasswordProvider)(
                  oldPassword: oldPassword,
                  newPassword: newPassword,
                );
                dismissIndicator(context);
                await showOkAlertDialog(
                  context: context,
                  title: '変更しました',
                );
                Navigator.of(context).pop();
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
