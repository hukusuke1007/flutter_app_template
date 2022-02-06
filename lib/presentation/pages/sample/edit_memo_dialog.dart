import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';
import '../../../model/entities/sample/memo.dart';
import '../../../model/use_cases/sample/memo_controller.dart';
import '../../../utils/logger.dart';
import '../../../utils/provider.dart';
import '../../res/colors.dart';
import '../../widgets/show_indicator.dart';

Future<void> showEditMemoDialog(
  BuildContext context, {
  Memo? data,
}) =>
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EditMemoDialog(data);
      },
    );

class EditMemoDialog extends HookConsumerWidget {
  const EditMemoDialog(
    this.data, {
    Key? key,
  }) : super(key: key);

  final Memo? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textKey = useState(GlobalKey<FormFieldState<String>>());

    useEffect(() {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        textKey.value.currentState?.didChange(data?.text);
      });
      return null;
    }, []);

    return GestureDetector(
      onTap: context.hideKeyboard,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        content: SizedBox(
          width: context.deviceWidth * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: TextFormField(
                  key: textKey.value,
                  initialValue: data?.text,
                  style: const TextStyle(fontSize: 15),
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
                      primary: kPrimaryColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      if (textKey.value.currentState?.validate() != true) {
                        return;
                      }
                      final text =
                          textKey.value.currentState?.value?.trim() ?? '';
                      try {
                        showIndicator(context);
                        context.hideKeyboard();
                        final gContext =
                            ref.read(navigatorKeyProvider).currentContext!;
                        if (data != null) {
                          /// 更新
                          await ref
                              .read(memoControllerProvider.notifier)
                              .update(data!.copyWith(text: text));
                          gContext.showSnackBar('更新しました');
                        } else {
                          /// 新規作成
                          await ref
                              .read(memoControllerProvider.notifier)
                              .create(text);
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
                      style: context.bodyStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '閉じる',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
