import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../extensions/context_extension.dart';
import '../../../../../model/entities/sample/github/user.dart';
import '../../../../../model/use_cases/sample/github/fetch_github_users.dart';
import '../../../../custom_hooks/use_effect_once.dart';
import '../../../../custom_hooks/use_refresh_controller.dart';
import '../../../../widgets/images/thumbnail.dart';
import '../../../../widgets/show_indicator.dart';
import '../../../../widgets/smart_refresher/smart_refresher_custom.dart';

class GithubUsersPage extends HookConsumerWidget {
  const GithubUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final refreshController = useRefreshController();
    final githubUsersState = useState(<User>[]);

    Future<void> onFetch({
      int? lastUserId,
    }) async {
      final result = await ref.read(fetchGithubUsersProvider)(
        lastUserId: lastUserId,
      );
      result.maybeWhen<void>(
        error: (e, _) {
          showOkAlertDialog(
            context: context,
            title: 'エラーが発生しました\n$e',
          );
        },
        orElse: () {
          final data = result.asData?.value ?? [];
          if (lastUserId != null) {
            githubUsersState.value = [...githubUsersState.value, ...data];
          } else {
            githubUsersState.value = data;
          }
        },
      );
    }

    useEffectOnce(() {
      Future(() async {
        showIndicator(context);
        await onFetch();
        dismissIndicator(context);
      });
      return null;
    });

    return Scaffold(
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
      body: SmartRefresher(
        header: const SmartRefreshHeader(),
        footer: const SmartRefreshFooter(),
        // ignore: avoid_redundant_argument_values
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController,
        physics: const BouncingScrollPhysics(),
        onRefresh: () async {
          await onFetch();
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          final items = githubUsersState.value;
          if (items.isNotEmpty) {
            await onFetch(lastUserId: items.last.id);
          }
          refreshController.loadComplete();
        },

        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            final data = githubUsersState.value[index];
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
                  launchUrl(Uri.parse(url));
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
          itemCount: githubUsersState.value.length,
        ),
      ),
    );
  }
}
