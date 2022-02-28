import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/use_cases/sample/my_profile/save_my_profile_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/date_extension.dart';
import '../../../model/use_cases/image_compress.dart';
import '../../../model/use_cases/sample/my_profile/fetch_my_profile.dart';
import '../../../model/use_cases/sample/my_profile/save_my_profile.dart';
import '../../../utils/logger.dart';
import '../../../utils/provider.dart';
import '../../../utils/vibration.dart';
import '../../res/colors.dart';
import '../../widgets/button.dart';
import '../../widgets/color_circle.dart';
import '../../widgets/dialogs/show_content_dialog.dart';
import '../../widgets/material_tap_gesture.dart';
import '../../widgets/sheets/show_date_picker_sheet.dart';
import '../../widgets/sheets/show_photo_and_crop_bottom_sheet.dart';
import '../../widgets/show_indicator.dart';
import '../../widgets/thumbnail.dart';

Future<void> showEditProfileDialog({
  required BuildContext context,
}) async {
  return showContentDialog(
    context: context,
    contentWidget: const _Dialog(),
  );
}

class _Dialog extends HookConsumerWidget {
  const _Dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchMyProfileProvider).value;

    final nameFormKey = useState<GlobalKey<FormFieldState<String>>>(
        GlobalKey<FormFieldState<String>>());
    final birthdateFormKey = useState<GlobalKey<FormFieldState<String>>>(
        GlobalKey<FormFieldState<String>>());
    final birthdateState = useState<DateTime?>(null);

    useEffect(() {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        nameFormKey.value.currentState?.didChange(profile?.name);
        birthdateFormKey.value.currentState?.didChange(profile?.birthdateLabel);
        birthdateState.value = profile?.birthdate;
      });
      return null;
    }, const []);

    return Column(
      children: [
        Stack(
          children: [
            CircleThumbnail(
              size: 96,
              url: profile?.image?.url,
              onTap: () {
                ///
              },
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ColorCircleIcon(
                onTap: () async {
                  final selectedImage = await showPhotoAndCropBottomSheet(
                    context,
                    title: 'プロフィール画像',
                  );
                  if (selectedImage == null) {
                    return;
                  }
                  final globalContext =
                      ref.read(navigatorKeyProvider).currentContext!;

                  /// 圧縮して設定
                  final compressImage =
                      await ref.read(imageCompressProvider)(selectedImage);
                  if (compressImage == null) {
                    return;
                  }

                  try {
                    showIndicator(globalContext);
                    await ref
                        .read(saveMyProfileImageProvider)
                        .call(compressImage);
                    globalContext.showSnackBar('画像を保存しました');
                  } on Exception catch (e) {
                    logger.shout(e);
                    globalContext.showSnackBar('画像を保存できませんでした',
                        backgroundColor: Colors.redAccent);
                  } finally {
                    dismissIndicator(globalContext);
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
              padding: const EdgeInsets.only(bottom: 4),
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
              key: nameFormKey.value,
              initialValue: profile?.name,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? '名前を入力してください'
                  : null,
              maxLines: 1,
              maxLength: 32,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('誕生日', style: context.bodyStyle),
            ),
            MaterialTapGesture(
              onTap: () async {
                context.hideKeyboard();
                unawaited(Vibration.select());
                final birthdate = birthdateState.value ?? DateTime.now();
                await showDatePickerSheet(
                  context,
                  date: birthdate,
                  onDateTimeChanged: (DateTime value) {
                    birthdateState.value = value;
                    birthdateFormKey.value.currentState
                        ?.didChange(value.format(format: 'yyyy/M/d'));
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
                  key: birthdateFormKey.value,
                  maxLines: 1,
                  initialValue: profile?.birthdateLabel,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: RoundedButton(
            onPressed: () async {
              context.hideKeyboard();
              if (!nameFormKey.value.currentState!.validate()) {
                return;
              }
              final name = nameFormKey.value.currentState?.value?.trim() ?? '';
              final birthdate = birthdateState.value;
              final globalContext =
                  ref.read(navigatorKeyProvider).currentContext!;
              try {
                showIndicator(globalContext);
                await ref.read(saveMyProfileProvider).call(
                      name: name,
                      birthdate: birthdate,
                    );
                globalContext.showSnackBar('保存しました');
                Navigator.of(context).pop();
              } on Exception catch (e) {
                logger.shout(e);
                globalContext.showSnackBar('保存できませんでした',
                    backgroundColor: Colors.redAccent);
              } finally {
                dismissIndicator(globalContext);
              }
            },
            bgColor: kPrimaryColor,
            width: 120,
            child: const Text(
              '保存する',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
