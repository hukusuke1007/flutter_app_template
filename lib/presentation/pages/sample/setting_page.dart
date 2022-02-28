import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../model/use_cases/auth/sign_out.dart';
import '../../../model/use_cases/package_info/fetch_app_name.dart';
import '../../../model/use_cases/package_info/fetch_app_version.dart';
import '../../../model/use_cases/package_info/fetch_package_name.dart';
import '../start_up_page.dart';
import '../web_view_page.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appName = ref.watch(fetchAppNameProvider);
    final appVersion = ref.watch(fetchAppVersionProvider);
    final packageName = ref.watch(fetchPackageNameProvider);
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
