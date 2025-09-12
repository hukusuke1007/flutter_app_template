import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/custom_hooks/use_effect_once.dart';
import '../../../core/entities/developer/developer.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/date_extension.dart';
import '../../../core/extensions/exception_extension.dart';
import '../../../core/extensions/scroll_controller_extension.dart';
import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/use_cases/analytics/analytics_event.dart';
import '../../../core/use_cases/analytics/analytics_logger.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/tab_tap_operation_provider.dart';
import '../../../core/widgets/buttons/ripple_tap_gesture.dart';
import '../../../core/widgets/images/image_viewer.dart';
import '../../../core/widgets/images/thumbnail.dart';
import '../../../core/widgets/show_indicator.dart';
import '../../start_up/pages/start_up_page.dart';
import '../use_cases/fetch_app_name.dart';
import '../use_cases/fetch_app_version.dart';
import '../use_cases/fetch_my_profile.dart';
import '../use_cases/fetch_package_name.dart';
import '../use_cases/sign_out.dart';
import 'dialogs/show_edit_profile_dialog.dart';
import 'web_view_page.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  static String get pageName => 'setting';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final appName = ref.watch(fetchAppNameProvider);
    final appVersion = ref.watch(fetchAppVersionProvider);
    final packageName = ref.watch(fetchPackageNameProvider);
    final profileAsyncValue = ref.watch(fetchMyProfileProvider);
    final profile = profileAsyncValue.asData?.value;

    final tabTapOperation = ref.watch(tabTapOperationProviders(pageName));

    useEffect(
      () {
        Future.microtask(() {
          if (context.mounted && profileAsyncValue.hasError) {
            showOkAlertDialog(
              context: context,
              title: profileAsyncValue.error?.toString(),
            );
          }
        });
        return null;
      },
      [profileAsyncValue.error],
    );

    useEffectOnce(() {
      /// 同じタブが選択された場合、上にスクロールする
      tabTapOperation.addListener((value) {
        if (value == TabTapOperationType.duplication) {
          scrollController.animateToTop();
        }
      });
      return null;
    });

    final tileTrailingWidth = context.deviceWidth * 0.5;
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
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProfileTile(
                  profile,
                  heroTag: 'profile',
                  onTapImage: () {
                    final url = profile?.image?.url;
                    if (url != null) {
                      ImageViewer.show(
                        context,
                        urls: [url],
                        heroTag: 'profile',
                      );
                    }
                  },
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
                      trailing: SizedBox(
                        width: tileTrailingWidth,
                        child: Text(
                          appName,
                          style: context.bodyStyle.copyWith(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'パッケージ名',
                        style: context.bodyStyle,
                      ),
                      trailing: SizedBox(
                        width: tileTrailingWidth,
                        child: Text(
                          packageName,
                          style: context.bodyStyle.copyWith(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'バージョン',
                        style: context.bodyStyle,
                      ),
                      trailing: SizedBox(
                        width: tileTrailingWidth,
                        child: Text(
                          appVersion,
                          style: context.bodyStyle.copyWith(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onTap: () {
                        WebViewPage.push(
                          context,
                          url: 'https://neverjp.com/',
                        );
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
                        if (context.mounted) {
                          showIndicator(context);
                        }
                        try {
                          /// ログアウトしたユーザーIDを記録したいため、サインアウトする前に取得する
                          final userId = ref
                              .read(firebaseAuthRepositoryProvider)
                              .loggedInUserId;

                          /// ログアウト実施
                          await ref.read(signOutProvider)();

                          /// アナリティクス送信
                          if (userId != null) {
                            await ref
                                .read(analyticsLoggerProvider)
                                .onEvent(
                                  AnalyticsEvent.signOut,
                                  params: AnalyticsEventParams.signOut(
                                    userId: userId,
                                  ),
                                );
                          }

                          if (context.mounted) {
                            dismissIndicator(context);
                            StartUpPage.pushReplacement(context);
                          }
                        } on Exception catch (e) {
                          logger.shout(e);
                          if (context.mounted) {
                            dismissIndicator(context);
                            context.showSnackBar(
                              e.errorMessage,
                              backgroundColor: Colors.grey,
                            );
                          }
                        }
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
    required this.heroTag,
    this.onTapImage,
    this.onTapTile,
    super.key,
  });

  final Developer? developer;
  final String heroTag;
  final VoidCallback? onTapImage;
  final VoidCallback? onTapTile;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: RippleTapGesture(
        onTap: onTapTile,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Hero(
                tag: heroTag,
                child: CircleThumbnail(
                  size: 48,
                  url: developer?.image?.url,
                  onTap: onTapImage,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ).copyWith(right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '名前: ${developer?.name ?? '-'}',
                        style: context.bodyStyle,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '誕生日: ${developer?.birthdate?.format(pattern: 'yyyy/M/d') ?? '-'}',
                        style: context.bodyStyle,
                      ),
                    ],
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
