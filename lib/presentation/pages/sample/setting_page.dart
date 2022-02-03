import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../model/use_cases/fetch_app_version.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(fetchAppVersion);
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
            ],
          ),
        ),
      ),
    );
  }
}
