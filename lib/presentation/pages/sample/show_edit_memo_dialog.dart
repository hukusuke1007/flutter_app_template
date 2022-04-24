import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';
import '../../../gen/colors.gen.dart';
import '../../../model/entities/sample/memo.dart';
import '../../../model/use_cases/sample/memo_controller.dart';
import '../../../utils/logger.dart';
import '../../../utils/provider.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../custom_hooks/use_form_field_state_key.dart';
import '../../widgets/dialogs/show_content_dialog.dart';
import '../../widgets/show_indicator.dart';

Future<void> showEditMemoDialog(
  BuildContext context, {
  Memo? data,
}) =>
    showContentDialog<void>(
      context: context,
      contentWidget: _Dialog(data),
    );

class _Dialog extends HookConsumerWidget {
  const _Dialog(
    this.data, {
    Key? key,
  }) : super(key: key);

  final Memo? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// カスタムフック
    final textKey = useFormFieldStateKey();

    /// カスタムフック
    useEffectOnce(() {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        textKey.currentState?.didChange(data?.text);
      });
      return null;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: TextFormField(
            key: textKey,
            initialValue: data?.text,
            style: context.bodyStyle,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? '正しい値を入力してください'
                : null,
            decoration: const InputDecoration(
              labelText: 'テキスト入力',
              hintText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.newline,
            minLines: 1,
            maxLines: 3,
            maxLength: 1024,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            height: 40,
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorName.primary,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                if (textKey.currentState?.validate() != true) {
                  return;
                }
                final text = textKey.currentState?.value?.trim() ?? '';
                try {
                  showIndicator(context);
                  context.hideKeyboard();
                  final gContext =
                      ref.read(navigatorKeyProvider).currentContext!;
                  if (data != null) {
                    /// 更新
                    await ref
                        .read(memoProvider.notifier)
                        .update(data!.copyWith(text: text));
                    gContext.showSnackBar('更新しました');
                  } else {
                    /// 新規作成
                    await ref.read(memoProvider.notifier).create(text);
                    gContext.showSnackBar('作成しました');
                  }
                  dismissIndicator(context);

                  Navigator.pop(context);
                } on Exception catch (e) {
                  logger.shout(e);
                  dismissIndicator(context);
                  context.showSnackBar(
                    e.errorMessage,
                    backgroundColor: Colors.grey,
                  );
                }
              },
              child: Text(
                '投稿する',
                style: context.bodyStyle
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
