import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../extensions/context_extension.dart';
import '../../../../../model/use_cases/sample/github/fetch_github_users.dart';
import '../../../../custom_hooks/use_refresh_controller.dart';
import '../../../../widgets/smart_refresher_custom.dart';
import '../../../../widgets/thumbnail.dart';
import '../error_message.dart';

class GithubUsersPage extends HookConsumerWidget {
  const GithubUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offsetState = useState(0);
    final githubUsers = ref.watch(fetchGithubUsersProviders(offsetState.value));

    final scrollController = useScrollController();
    final refreshController = useRefreshController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Github Users',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: githubUsers.maybeWhen(
        error: (e, _) => ErrorMessage(
          detail: e.toString(),
          onTapRetry: () {
            offsetState.value = 0;
            ref.refresh(fetchGithubUsersProviders(offsetState.value));
          },
        ),
        orElse: () {
          final items = githubUsers.value ?? [];
          return Scrollbar(
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
                ref.refresh(fetchGithubUsersProviders(offsetState.value));
                refreshController.refreshCompleted();
              },
              onLoading: () {
                // TODO(shohei): 未実装
                refreshController.loadComplete();
              },

              child: ListView.separated(
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final data = items[index];
                  return ListTile(
                    leading: CircleThumbnail(
                      size: 40,
                      url: data.avatarUrl,
                    ),
                    title: Text(
                      data.login,
                      style: context.bodyStyle,
                    ),
                    subtitle: Text(
                      data.htmlUrl ?? '-',
                      style: context.smallStyle,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      final url = data.htmlUrl;
                      if (url != null) {
                        launch(url);
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1);
                },
                itemCount: items.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
