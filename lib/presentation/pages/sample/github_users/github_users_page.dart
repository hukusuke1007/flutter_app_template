import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../model/use_cases/sample/github/github_users_controller.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../custom_hooks/use_refresh_controller.dart';
import '../../../widgets/smart_refresher_custom.dart';
import '../../../widgets/thumbnail.dart';

class GithubUsersPage extends HookConsumerWidget {
  const GithubUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(githubUsersControllerProvider);
    final scrollController = useScrollController();

    final refreshController = useRefreshController();

    useEffectOnce(() {
      Future(() async {
        final result =
            await ref.read(githubUsersControllerProvider.notifier).fetch();
        result.when(
          success: (data) {},
          failure: (e) {
            context.showSnackBar(
              e.errorMessage,
              backgroundColor: Colors.grey,
            );
          },
        );
      });
      return null;
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'メモ',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SmartRefresher(
          header: const SmartRefreshHeader(),
          footer: const SmartRefreshFooter(),
          // ignore: avoid_redundant_argument_values
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          physics: const BouncingScrollPhysics(),
          onRefresh: () async {
            final result =
                await ref.read(githubUsersControllerProvider.notifier).fetch();
            refreshController.refreshCompleted();
            result.when(
              success: (_) {},
              failure: (e) {
                context.showSnackBar(
                  e.errorMessage,
                  backgroundColor: Colors.grey,
                );
              },
            );
          },
          onLoading: () async {
            final result = await ref
                .read(githubUsersControllerProvider.notifier)
                .fetchMore();
            refreshController.loadComplete();
            result.when(
              success: (_) {},
              failure: (e) {
                context.showSnackBar(
                  e.errorMessage,
                  backgroundColor: Colors.grey,
                );
              },
            );
          },
          child: ListView.separated(
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) {
              final data = items[index];
              return ListTile(
                leading: CircleThumbnail(
                  size: 40,
                  url: data.url,
                ),
                title: Text(
                  data.login,
                  style: context.bodyStyle,
                ),
                trailing: Text(
                  data.url,
                  style: context.smallStyle,
                ),
                onTap: () {
                  launch(data.url);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1);
            },
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}
