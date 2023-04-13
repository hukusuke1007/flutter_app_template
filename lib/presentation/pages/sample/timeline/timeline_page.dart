import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../model/use_cases/sample/timeline/fetch_timeline.dart';
import '../../../../model/use_cases/sample/timeline/fetch_timeline_post_count.dart';
import '../../../../model/use_cases/sample/timeline/post/fetch_post.dart';
import '../../../../utils/logger.dart';
import '../../../custom_hooks/use_refresh_controller.dart';
import '../../../widgets/error_text.dart';
import '../../../widgets/smart_refresher_custom.dart';
import '../../image_viewer/image_viewer.dart';
import '../../main/main_page.dart';
import 'edit_post_page.dart';
import 'post_detail_page.dart';
import 'widgets/timeline_tile.dart';

class TimelinePage extends HookConsumerWidget {
  const TimelinePage({super.key});

  static String get pageName => 'timeline';
  static String get pagePath => '${MainPage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(BuildContext context) {
    context.push(pagePath);
  }

  /// go_routerの画面遷移
  static void go(BuildContext context) {
    context.go(pagePath);
  }

  /// 従来の画面遷移
  static Future<void> showNav1(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => const TimelinePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final refreshController = useRefreshController();

    final asyncValue = ref.watch(fetchTimelineAsyncProvider);

    final count =
        ref.watch(fetchTimelinePostCountFutureProvider).asData?.value ?? 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'タイムライン',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: Text(
              '全$count件',
              style: context.bodyStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: asyncValue.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(bottom: 80),
                child: Text(
                  'タイムラインはありません',
                  style: context.bodyStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return Scrollbar(
            controller: scrollController,
            child: SmartRefresher(
              header: const SmartRefreshHeader(),
              footer: const SmartRefreshFooter(),
              enablePullUp: true,
              controller: refreshController,
              physics: const BouncingScrollPhysics(),
              onRefresh: () async {
                ref
                  ..invalidate(fetchTimelineAsyncProvider)
                  ..invalidate(fetchTimelinePostCountFutureProvider);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await ref
                    .read(fetchTimelineAsyncProvider.notifier)
                    .onFetchMore();
                refreshController.loadComplete();
              },
              child: ListView.separated(
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final data = items[index];
                  return TimelineTile(
                    data: data,
                    onTap: () {
                      PostDetailPage.push(
                        context,
                        args: FetchPostArgs(
                          postId: data.postId,
                          userId: data.userId,
                        ),
                      );
                    },
                    onTapAvatar: (poster) {
                      final url = poster?.image?.url;
                      if (url != null) {
                        ImageViewer.show(
                          context,
                          urls: [url],
                        );
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
        error: (e, stackTrace) {
          logger.shout(e);
          final message = 'エラー\n$e';
          return ErrorText(
            message: message,
            onRetry: () {
              ref.invalidate(fetchTimelineAsyncProvider);
            },
          );
        },
        loading: () => const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EditPostPage.push(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
