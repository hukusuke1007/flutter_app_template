import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/date_extension.dart';
import '../../../model/entities/sample/developer.dart';
import '../../../model/use_cases/auth/sign_out.dart';
import '../../../model/use_cases/package_info/fetch_app_name.dart';
import '../../../model/use_cases/package_info/fetch_app_version.dart';
import '../../../model/use_cases/package_info/fetch_package_name.dart';
import '../../../model/use_cases/sample/my_profile/fetch_my_profile.dart';
import '../../../presentation/pages/sample/show_edit_profile_dialog.dart';
import '../../../presentation/widgets/material_tap_gesture.dart';
import '../../widgets/thumbnail.dart';
import '../start_up_page.dart';
import '../web_view_page.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appName = ref.watch(fetchAppNameProvider);
    final appVersion = ref.watch(fetchAppVersionProvider);
    final packageName = ref.watch(fetchPackageNameProvider);
    final profile = ref.watch(fetchMyProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProfileTile(
                  profile.value,
                  onTapTile: () {
                    showEditProfileDialog(context: context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Text(
                  'アプリ',
                  style: context.smallStyle,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'アプリ名',
                        style: context.bodyStyle,
                      ),
                      trailing: Text(
                        appName,
                        style: context.bodyStyle.copyWith(color: Colors.grey),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'パッケージ名',
                        style: context.bodyStyle,
                      ),
                      trailing: Text(
                        packageName,
                        style: context.bodyStyle.copyWith(color: Colors.grey),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'バージョン',
                        style: context.bodyStyle,
                      ),
                      trailing: Text(
                        appVersion,
                        style: context.bodyStyle.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Text(
                  '運営',
                  style: context.smallStyle,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        WebViewPage.show(context, url: 'https://neverjp.com/');
                      },
                      title: Text(
                        '株式会社Never',
                        style: context.bodyStyle,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: TextButton(
                    child: Text(
                      'ログアウト',
                      style: context.smallStyle.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () async {
                      final result = await showOkCancelAlertDialog(
                        context: context,
                        title: 'ログアウト',
                        message: 'ログアウトしますか？',
                      );
                      if (result == OkCancelResult.ok) {
                        await ref.read(signOutProvider)();
                        unawaited(StartUpPage.show(context));
                      }
                    },
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

class ProfileTile extends StatelessWidget {
  const ProfileTile(
    this.developer, {
    this.onTapTile,
    Key? key,
  }) : super(key: key);

  final Developer? developer;
  final VoidCallback? onTapTile;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: MaterialTapGesture(
          onTap: onTapTile,
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleThumbnail(
                  size: 48,
                  url: developer?.image?.url,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '名前: ${developer?.name ?? '-'}',
                        style: context.bodyStyle,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        // ignore: lines_longer_than_80_chars
                        '誕生日: ${developer?.birthdate?.format(format: 'yyyy/M/d') ?? '-'}',
                        style: context.bodyStyle,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
