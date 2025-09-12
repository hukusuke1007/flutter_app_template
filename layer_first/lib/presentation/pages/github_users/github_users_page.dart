import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/scroll_controller_extension.dart';
import '../../../model/use_cases/github_users/github_users_controller.dart';
import '../../../utils/tab_tap_operation_provider.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../widgets/images/thumbnail.dart';
import '../../widgets/pull_to_refresh/pull_to_refresh.dart';
import 'widgets/error_message.dart';

class GithubUsersPage extends HookConsumerWidget {
  const GithubUsersPage({super.key});

  static String get pageName => 'github_users';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubUsers = ref.watch(githubUsersControllerProvider);
    final scrollController = useScrollController();
    final tabTapOperation = ref.watch(tabTapOperationProviders(pageName));

    useEffectOnce(() {
      /// 同じタブが選択された場合、上にスクロールする
      tabTapOperation.addListener((value) {
        if (value == TabTapOperationType.duplication) {
          scrollController.animateToTop();
        }
      });
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Github Users',
          style: context.subtitleStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: githubUsers.when(
        data: (items) {
          // Github API は per_page=20 で取得しているため、総件数を持たないが
          // 長さが 20 の倍数であれば更に続きを期待できる可能性が高い。
          return PullToRefresh(
            controller: scrollController,
            pageSize: 20,
            itemCount: items.length,
            onRefresh: () async {
              ref.invalidate(githubUsersControllerProvider);
              // 再取得完了まで待機してインジケータを閉じる
              await ref.read(githubUsersControllerProvider.future);
            },
            onLoadMore: () async {
              await ref
                  .read(githubUsersControllerProvider.notifier)
                  .onFetchMore();
            },
            slivers: [
              SliverList.separated(
                itemBuilder: (BuildContext context, int index) {
                  final data = items[index];
                  return ListTile(
                    leading: CircleThumbnail(size: 40, url: data.avatarUrl),
                    title: Text(data.login, style: context.bodyStyle),
                    subtitle: Text(
                      data.htmlUrl ?? '-',
                      style: context.smallStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      final url = data.htmlUrl;
                      if (url != null) {
                        launchUrl(Uri.parse(url));
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1);
                },
                itemCount: items.length,
              ),

              if (items.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text('ユーザーが見つかりません'),
                  ),
                ),
            ],
          );
        },
        error: (e, _) => ErrorMessage(
          message: e.toString(),
          onTapRetry: () {
            ref.invalidate(githubUsersControllerProvider);
          },
        ),
        loading: () => const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
