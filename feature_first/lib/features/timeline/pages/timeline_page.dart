import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../features/app_wrapper/pages/main_page.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/widgets/images/image_viewer.dart';
import '../../../../core/widgets/texts/error_text.dart';
import '../use_cases/fetch_timeline.dart';
import '../use_cases/fetch_timeline_post_count.dart';
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
    final loadingState = useState(false);

    final asyncValue = ref.watch(fetchTimelineProvider);
    final count = ref.watch(fetchTimelinePostCountProvider).asData?.value ?? 0;

    ref.listen(fetchTimelinePostCountProvider, (prev, next) {
      if (!next.isLoading && next.hasError) {
        showOkAlertDialog(context: context, title: next.error?.toString());
      }
    });

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
          return NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (items.length >= FetchTimeline.defaultLimit &&
                  notification.metrics.extentAfter == 0) {
                Future(() async {
                  if (loadingState.value) {
                    return;
                  }
                  loadingState.value = true;
                  try {
                    await Future<void>.delayed(
                      const Duration(milliseconds: 1000),
                    );
                    await ref
                        .read(fetchTimelineProvider.notifier)
                        .onFetchMore();
                  } on Exception catch (e) {
                    logger.shout(e);
                    // TODO(shohei): エラーハンドリング
                  } finally {
                    if (context.mounted) {
                      loadingState.value = false;
                    }
                  }
                });
              }
              return true;
            },
            child: CustomScrollView(
              controller: scrollController,

              /// スクロールできる領域がなくても、Pull To Refreshできるようにスクロール可能にする
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                /// Pull To Refresh
                CupertinoSliverRefreshControl(
                  builder: (_, refreshState, __, ___, ____) {
                    // TODO(shohei): インジケータのサイズを変更したいためbuilderで実装
                    if (refreshState == RefreshIndicatorMode.done ||
                        refreshState == RefreshIndicatorMode.inactive ||
                        refreshState == RefreshIndicatorMode.drag) {
                      return const SizedBox.shrink();
                    }
                    return const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: CupertinoActivityIndicator(),
                    );
                  },
                  onRefresh: () async {
                    ref
                      ..invalidate(fetchTimelineProvider)
                      ..invalidate(fetchTimelinePostCountProvider);
                    await Future<void>.delayed(
                      const Duration(milliseconds: 1000),
                    );
                  },
                ),

                /// リスト + Paginationのインジケータ
                SliverMainAxisGroup(
                  slivers: [
                    SliverList.separated(
                      itemBuilder: (context, index) {
                        final data = items[index];
                        return TimelineTile(
                          data: data,
                          onTap: () {
                            PostDetailPage.push(
                              context,
                              posterId: data.userId,
                              postId: data.postId,
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
                      separatorBuilder: (context, index) {
                        return const Divider(height: 1);
                      },
                      itemCount: items.length,
                    ),

                    /// Pagination処理中のインジケータ
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16, bottom: 56),
                      sliver: SliverToBoxAdapter(
                        child: Visibility(
                          visible: loadingState.value,
                          child: const CupertinoActivityIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),

                /// リストがない時の表示
                if (items.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16)
                            .copyWith(bottom: 108),
                        child: Text(
                          'タイムラインはありません',
                          style: context.bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        error: (e, stackTrace) {
          logger.shout(e);
          final message = 'エラー\n$e';
          return ErrorText(
            message: message,
            onRetry: () {
              ref.invalidate(fetchTimelineProvider);
            },
          );
        },
        loading: () => const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          EditPostPage.push(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
