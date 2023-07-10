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
import '../../../../model/use_cases/sample/auth/email/sign_up_with_email_and_password.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../custom_hooks/use_form_field_state_key.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../../../widgets/show_indicator.dart';
import 'top_email_feature_page.dart';
import 'widgets/email_text_field.dart';
import 'widgets/passward_text_field.dart';

class SignUpWithEmailPage extends HookConsumerWidget {
  const SignUpWithEmailPage({super.key});

  static String get pageName => 'sign_up_with_email';
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
        builder: (_) => const SignUpWithEmailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final emailFormFieldKey = useFormFieldStateKey();
    final passwordFormFieldKey = useFormFieldStateKey();
    final confirmPasswordFormFieldKey = useFormFieldStateKey();
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
                /// メールアドレス
                EmailTextField(
                  key: const Key('emailTextField'),
                  textFormFieldKey: emailFormFieldKey,
                  focusNode: focusNode,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  hintText: 'メールアドレスを入力',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => focusNode.nextFocus(),
                ),

                /// パスワード
                PasswordTextField(
                  key: const Key('passwordTextField'),
                  textFormFieldKey: passwordFormFieldKey,
                  padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
                    bottom: 16,
                  ),
                  hintText: '大文字小文字含む英数字8桁以上',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => focusNode.nextFocus(),
                ),

                /// 確認用パスワード
                PasswordTextField(
                  key: const Key('confirmPasswordTextField'),
                  textFormFieldKey: confirmPasswordFormFieldKey,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  title: '確認用パスワード',
                  hintText: '確認用パスワードを入力',
                  validator: (value) {
                    final passwordText =
                        passwordFormFieldKey.currentState?.value?.trim();
                    if (value == null ||
                        !value.trim().isPassword ||
                        value != passwordText) {
                      return '正しいパスワードを入力してください';
                    }
                    return null;
                  },
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
                '新規登録',
                style: context.bodyStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () async {
              final isValidEmail =
                  emailFormFieldKey.currentState?.validate() ?? false;
              final isValidPassword =
                  passwordFormFieldKey.currentState?.validate() ?? false;
              final isValidConfirmPassword =
                  confirmPasswordFormFieldKey.currentState?.validate() ?? false;
              if (!isValidEmail ||
                  !isValidPassword ||
                  !isValidConfirmPassword) {
                logger.info('invalid input data');
                return;
              }
              final email = emailFormFieldKey.currentState?.value;
              final password = passwordFormFieldKey.currentState?.value;
              if (email == null || password == null) {
                return;
              }

              try {
                showIndicator(context);
                await ref.read(signUpWithEmailAndPasswordProvider)(
                  email: email,
                  password: password,
                );
                dismissIndicator(context);
                await showOkAlertDialog(
                  context: context,
                  title: '新規登録しました',
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
