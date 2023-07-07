import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../extensions/string_extension.dart';
import '../../../../model/use_cases/sample/auth/email/change_email_address.dart';
import '../../../../model/use_cases/sample/auth/email/fetch_email.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../custom_hooks/use_form_field_state_key.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../../../widgets/show_indicator.dart';
import 'top_email_feature_page.dart';
import 'widgets/current_email_address_text.dart';
import 'widgets/email_text_field.dart';
import 'widgets/passward_text_field.dart';

class ChangeEmailAddressPage extends HookConsumerWidget {
  const ChangeEmailAddressPage({super.key});

  static String get pageName => 'change_email_address';
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
            'メールアドレスの変更',
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
                CurrentEmailAddressText(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  email: currentEmail ?? '-',
                ),

                /// 新しいメールアドレス
                EmailTextField(
                  textFormFieldKey: newEmailFormFieldKey,
                  focusNode: focusNode,
                  padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
                    bottom: 16,
                  ),
                  title: '新しいメールアドレス',
                  hintText: 'メールアドレスを入力',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => focusNode.nextFocus(),
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
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => focusNode.nextFocus(),
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
