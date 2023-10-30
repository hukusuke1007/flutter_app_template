import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/custom_hooks/use_form_field_state_key.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/exception_extension.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../core/widgets/show_indicator.dart';
import '../use_cases/post_controller.dart';
import 'timeline_page.dart';

class EditPostPageArgs extends Equatable {
  const EditPostPageArgs({
    required this.posterId,
    required this.postId,
  });

  final String posterId;
  final String postId;

  @override
  List<Object?> get props => [posterId, postId];
}

class EditPostPage extends HookConsumerWidget {
  const EditPostPage({
    this.args,
    super.key,
  });

  static String get pageName => 'edit_post';
  static String get pagePath => '${TimelinePage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(
    BuildContext context, {
    EditPostPageArgs? args,
  }) {
    context.push(
      pagePath,
      extra: args,
    );
  }

  /// 従来の画面遷移
  static Future<void> showNav1(
    BuildContext context, {
    EditPostPageArgs? args,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => EditPostPage(
          args: args,
        ),
      ),
    );
  }

  final EditPostPageArgs? args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final textFormFieldKey = useFormFieldStateKey();
    final posterId = args?.posterId;
    final postId = args?.postId;
    final isUpdatePost = posterId != null && postId != null;
    final provider = postControllerProvider(posterId: posterId, postId: postId);
    final post = ref
        .watch(postControllerProvider(posterId: posterId, postId: postId))
        .asData
        ?.value;

    return GestureDetector(
      onTap: context.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            isUpdatePost ? '投稿を更新' : '投稿を作成',
            style: context.subtitleStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            if (isUpdatePost)
              IconButton(
                onPressed: () async {
                  if (post == null) {
                    return;
                  }
                  context.hideKeyboard();
                  final result = await showOkCancelAlertDialog(
                    context: context,
                    title: '投稿を削除しますか？',
                  );
                  if (result != OkCancelResult.ok) {
                    return;
                  }
                  try {
                    showIndicator(context);
                    await ref.read(provider.notifier).onDelete();
                    dismissIndicator(context);
                    context
                      ..showSnackBar('削除しました')
                      // TODO(shohei): 暫定対応
                      ..pop()
                      ..pop();
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
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
          ],
        ),
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            reverse: true,
            controller: scrollController,
            padding: EdgeInsets.only(bottom: context.viewInsetsBottom),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '内容',
                    style:
                        context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    key: textFormFieldKey,
                    initialValue: post?.text ?? '',
                    style: context.bodyStyle,
                    decoration: const InputDecoration(
                      hintText: 'Aa',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(), // 外枠付きデザイン
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? '内容を入力してください'
                            : null,
                    minLines: 4,
                    maxLines: 16,
                    maxLength: 1024,
                    textInputAction: TextInputAction.newline,
                  ),
                  Center(
                    child: RoundedButton(
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
                        final isValidText =
                            textFormFieldKey.currentState?.validate() ?? false;

                        if (!isValidText) {
                          logger.info('invalid input data');
                          return;
                        }
                        final text = textFormFieldKey.currentState?.value;

                        if (text == null) {
                          return;
                        }

                        try {
                          context.hideKeyboard();
                          showIndicator(context);
                          if (isUpdatePost && post != null) {
                            /// 投稿内容を更新する
                            await ref
                                .read(provider.notifier)
                                .onUpdate(text: text);
                          } else {
                            /// 投稿内容を作成する
                            await ref
                                .read(provider.notifier)
                                .onCreate(text: text);
                          }
                          dismissIndicator(context);
                          context
                            ..showSnackBar(isUpdatePost ? '更新しました' : '投稿しました')
                            ..pop();
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
