import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../model/entities/sample/enum/operation_type.dart';
import '../../../../model/entities/sample/timeline/post.dart';
import '../../../../model/use_cases/sample/timeline/post/create_post.dart';
import '../../../../model/use_cases/sample/timeline/post/delete_post.dart';
import '../../../../model/use_cases/sample/timeline/post/update_post.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_form_field_state_key.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/show_indicator.dart';

@immutable
class EditPostPageResult {
  const EditPostPageResult({
    required this.operationType,
  });
  final OperationType operationType;
}

class EditPostPage extends HookConsumerWidget {
  const EditPostPage({
    this.oldPost,
    super.key,
  });

  static String get pageName => 'edit_post';
  static String get pagePath => '/$pageName';

  static Future<EditPostPageResult?> show(
    BuildContext context, {
    Post? oldPost,
  }) {
    return Navigator.of(context, rootNavigator: true).push<EditPostPageResult?>(
      CupertinoPageRoute(
        builder: (_) => EditPostPage(
          oldPost: oldPost,
        ),
      ),
    );
  }

  final Post? oldPost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final textFormFieldKey = useFormFieldStateKey();

    final isUpdatePost = oldPost != null;

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
                  final post = oldPost;
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
                    await ref.read(deletePostProvider)(post);
                    dismissIndicator(context);
                    context.showSnackBar('削除しました');
                    Navigator.of(context).pop(
                      const EditPostPageResult(
                        operationType: OperationType.delete,
                      ),
                    );
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
            controller: scrollController,
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
                    initialValue: oldPost?.text ?? '',
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
                    maxLines: 8,
                    maxLength: 1024,
                    textInputAction: TextInputAction.newline,
                  ),
                ],
              ),
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          RoundedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                isUpdatePost ? '更新する' : '投稿する',
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
                showIndicator(context);
                if (isUpdatePost) {
                  final data = oldPost;
                  if (data != null) {
                    await ref.read(updatePostProvider)(
                      oldPost: data,
                      text: text,
                    );
                  }
                } else {
                  await ref.read(createPostProvider)(text: text);
                }
                dismissIndicator(context);
                context.showSnackBar(isUpdatePost ? '更新しました' : '投稿しました');
                Navigator.of(context).pop(
                  EditPostPageResult(
                    operationType: isUpdatePost
                        ? OperationType.update
                        : OperationType.create,
                  ),
                );
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
