import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../extensions/string_extension.dart';
import '../../../../model/use_cases/auth/email/change_email_address.dart';
import '../../../../model/use_cases/auth/email/fetch_email.dart';
import '../../../../utils/clipboard.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_form_field_state_key.dart';
import '../../../widgets/ripple_tap_gesture.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/show_indicator.dart';
import 'widgets/email_text_field.dart';
import 'widgets/passward_text_field.dart';

class ChangeEmailAddressPage extends HookConsumerWidget {
  const ChangeEmailAddressPage({super.key});

  static String get pageName => 'change_email_address';
  static String get pagePath => '/$pageName';

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute(
        builder: (_) => const ChangeEmailAddressPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final newEmailFormFieldKey = useFormFieldStateKey();
    final newConfirmEmailFormFieldKey = useFormFieldStateKey();
    final passwordFormFieldKey = useFormFieldStateKey();

    final currentEmail = ref.watch(fetchEmailProvider);

    return GestureDetector(
      onTap: context.hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'メールアドレス変更',
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
                /// 現在のメールアドレス
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '現在のメールアドレス',
                          style: context.bodyStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        RippleTapGesture(
                          onTap: () {
                            final value = currentEmail;
                            if (value != null) {
                              Clipboard.copy(value);
                              context.showSnackBar('メールアドレスをコピーしました');
                            }
                          },
                          child: Text(
                            currentEmail ?? '-',
                            style: context.bodyStyle
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 新しいメールアドレス
                EmailTextField(
                  textFormFieldKey: newEmailFormFieldKey,
                  padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
                    bottom: 16,
                  ),
                  title: '新しいメールアドレス',
                  hintText: 'メールアドレスを入力',
                ),

                /// 新しいメールアドレス（確認）
                EmailTextField(
                  textFormFieldKey: newConfirmEmailFormFieldKey,
                  padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
                    bottom: 16,
                  ),
                  title: '新しいメールアドレス（確認）',
                  hintText: '確認用メールアドレスを入力',
                  validator: (value) {
                    final emailText =
                        newEmailFormFieldKey.currentState?.value?.trim();
                    if (value == null ||
                        !value.trim().isEmail ||
                        value != emailText) {
                      return '正しいメールアドレスを入力してください';
                    }
                    return null;
                  },
                ),

                /// パスワード
                PasswordTextField(
                  textFormFieldKey: passwordFormFieldKey,
                  padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
                    bottom: 16,
                  ),
                  hintText: '大文字小文字含む英数字8桁以上',
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
                '変更する',
                style: context.bodyStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () async {
              final isValidNewEmail =
                  newEmailFormFieldKey.currentState?.validate() ?? false;
              final isValidNewEmailConfirmPassword =
                  newConfirmEmailFormFieldKey.currentState?.validate() ?? false;
              final isValidPassword =
                  passwordFormFieldKey.currentState?.validate() ?? false;

              if (!isValidNewEmail ||
                  !isValidNewEmailConfirmPassword ||
                  !isValidPassword) {
                logger.info('invalid input data');
                return;
              }
              final newEmail = newEmailFormFieldKey.currentState?.value;
              final newConfirmEmail =
                  newConfirmEmailFormFieldKey.currentState?.value;
              final password = passwordFormFieldKey.currentState?.value;
              if (newEmail == null ||
                  newConfirmEmail == null ||
                  password == null) {
                return;
              }

              try {
                showIndicator(context);
                await ref.read(changeEmailAddressProvider)(
                  newEmail: newEmail,
                  password: password,
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
