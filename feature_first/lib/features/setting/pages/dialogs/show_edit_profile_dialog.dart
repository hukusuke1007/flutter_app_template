import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/custom_hooks/use_effect_once.dart';
import '../../../../core/custom_hooks/use_form_field_state_key.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/date_extension.dart';
import '../../../../core/repositories/file/file_repository.dart';
import '../../../../core/res/gen/colors.gen.dart';
import '../../../../core/use_cases/images/image_compress.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/vibration.dart';
import '../../../../core/widgets/buttons/ripple_tap_gesture.dart';
import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../core/widgets/color_circle.dart';
import '../../../../core/widgets/dialogs/show_content_dialog.dart';
import '../../../../core/widgets/images/image_viewer.dart';
import '../../../../core/widgets/images/thumbnail.dart';
import '../../../../core/widgets/sheets/show_date_picker_sheet.dart';
import '../../../../core/widgets/sheets/show_photo_and_crop_bottom_sheet.dart';
import '../../../../core/widgets/show_indicator.dart';
import '../../use_cases/fetch_my_profile.dart';
import '../../use_cases/save_my_profile.dart';
import '../../use_cases/save_my_profile_image.dart';

Future<void> showEditProfileDialog({
  required BuildContext context,
}) async {
  return showContentDialog(
    context: context,
    contentWidget: const _Dialog(),
  );
}

class _Dialog extends HookConsumerWidget {
  const _Dialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchMyProfileProvider).asData?.value;
    final birthdateState = useState<DateTime?>(profile?.birthdate);

    final nameFormKey = useFormFieldStateKey();
    final birthdateFormKey = useFormFieldStateKey();

    useEffectOnce(() {
      nameFormKey.currentState?.didChange(profile?.name);
      birthdateFormKey.currentState?.didChange(profile?.birthdateLabel);
      return null;
    });

    return Column(
      children: [
        Stack(
          children: [
            CircleThumbnail(
              size: 96,
              url: profile?.image?.url,
              onTap: () {
                final url = profile?.image?.url;
                if (url != null) {
                  ImageViewer.show(context, urls: [url]);
                }
              },
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ColorCircleIcon(
                onTap: () async {
                  final selectedImage = await showPhotoAndCropBottomSheet(
                    ref,
                    title: 'プロフィール画像',
                  );
                  if (selectedImage == null) {
                    return;
                  }

                  /// 圧縮して設定
                  final compressImage =
                      await ref.read(imageCompressProvider)(selectedImage);
                  if (compressImage == null) {
                    return;
                  }
                  logger.info(compressImage.lengthInBytes);
                  try {
                    showIndicator(context);
                    await ref
                        .read(saveMyProfileImageProvider)
                        .call(compressImage);
                  } on Exception catch (e) {
                    logger.shout(e);
                    await showOkAlertDialog(
                      context: context,
                      title: '画像を保存できませんでした',
                    );
                  } finally {
                    dismissIndicator(context);

                    await ref
                        .read(fileRepositoryProvider)
                        .delete(selectedImage.path); // fileがtmpに残ってしまうので削除
                  }
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // 入力フォーム
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text('名前', style: context.bodyStyle),
            ),
            TextFormField(
              style: context.bodyStyle,
              decoration: const InputDecoration(
                hintText: '名前を入力してください',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(),
                isDense: true,
                counterText: '',
              ),
              key: nameFormKey,
              initialValue: profile?.name,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? '名前を入力してください'
                  : null,
              maxLength: 32,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text('誕生日', style: context.bodyStyle),
            ),
            RippleTapGesture(
              onTap: () async {
                context.hideKeyboard();
                unawaited(Vibration.select());
                final birthdate = birthdateState.value ?? DateTime.now();
                await showDatePickerSheet(
                  context,
                  date: birthdate,
                  onDateTimeChanged: (DateTime value) {
                    birthdateState.value = value;
                    birthdateFormKey.currentState
                        ?.didChange(value.format(pattern: 'yyyy/M/d'));
                  },
                );
              },
              child: IgnorePointer(
                child: TextFormField(
                  style: context.bodyStyle,
                  decoration: const InputDecoration(
                    hintText: '誕生日を設定してください',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  key: birthdateFormKey,
                  initialValue: profile?.birthdateLabel,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: RoundedButton(
            elevation: 2,
            onTap: () async {
              context.hideKeyboard();
              if (!nameFormKey.currentState!.validate()) {
                return;
              }
              final name = nameFormKey.currentState?.value?.trim() ?? '';
              final birthdate = birthdateState.value;
              try {
                showIndicator(context);
                await ref.read(saveMyProfileProvider).call(
                      name: name,
                      birthdate: birthdate,
                    );
                dismissIndicator(context);
                context.showSnackBar('保存しました');
                Navigator.of(context).pop();
              } on Exception catch (e) {
                logger.shout(e);
                dismissIndicator(context);
                await showOkAlertDialog(context: context, title: '保存できませんでした');
              }
            },
            color: ColorName.primary,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                '保存する',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
