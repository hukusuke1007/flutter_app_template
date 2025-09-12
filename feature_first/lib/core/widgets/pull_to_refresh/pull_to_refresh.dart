import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PullToRefresh extends HookWidget {
  const PullToRefresh({
    super.key,
    required this.slivers,
    this.onRefresh,
    this.onLoadMore,
    this.pageSize,
    this.itemCount,
    this.enableRefresh = true,
    this.enablePagination = true,
    this.controller,
    this.physics,
    this.refreshIndicatorBuilder,
    this.paginationIndicator,
    this.paginationPadding = const EdgeInsets.only(top: 16, bottom: 24),
  });

  /// スクロール内容（リスト等）を表す Sliver 群
  final List<Widget> slivers;

  /// Pull-To-Refresh 時に呼び出す処理
  final Future<void> Function()? onRefresh;

  /// 末尾到達時に呼び出す処理
  final Future<void> Function()? onLoadMore;

  /// ページサイズ（hasMore 判定に使用）。
  /// `enablePagination` が true の場合は、`itemCount` とセットでの指定を推奨。
  final int? pageSize;

  /// 現在のアイテム総数（hasMore 判定に使用）。
  /// `enablePagination` が true の場合は、`pageSize` とセットでの指定を推奨。
  final int? itemCount;

  /// Pull-To-Refresh を有効にするか
  final bool enableRefresh;

  /// Pagination(無限スクロール) を有効にするか
  final bool enablePagination;

  /// 外部から渡す ScrollController（任意）
  final ScrollController? controller;

  /// スクロールの挙動（未指定時は常にスクロール可能 + Bouncing）
  final ScrollPhysics? physics;

  /// Refresh インジケータのビルダー（未指定時はデフォルトのスピナー）
  final Widget Function(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  )?
  refreshIndicatorBuilder;

  /// Pagination 中に末尾へ表示するインジケータ
  final Widget? paginationIndicator;

  /// Pagination インジケータ周辺の余白
  final EdgeInsetsGeometry paginationPadding;

  @override
  Widget build(BuildContext context) {
    final isLoadingMore = useState(false);

    // デフォルトの Refresh インジケータ
    Widget defaultRefreshBuilder(
      BuildContext _,
      RefreshIndicatorMode state,
      double _,
      double _,
      double _,
    ) {
      if (state == RefreshIndicatorMode.done ||
          state == RefreshIndicatorMode.inactive ||
          state == RefreshIndicatorMode.drag) {
        return const SizedBox.shrink();
      }
      return const Padding(
        padding: EdgeInsets.only(top: 16),
        child: CupertinoActivityIndicator(),
      );
    }

    Future<void> handleLoadMore() async {
      if (!enablePagination) {
        return;
      }
      if (onLoadMore == null) {
        return;
      }
      if (pageSize == null || itemCount == null) {
        return;
      }
      final hasMore = itemCount! > 0 && (itemCount! % pageSize! == 0);
      if (!hasMore) {
        return;
      }
      if (isLoadingMore.value) {
        return;
      }
      isLoadingMore.value = true;
      try {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        await onLoadMore?.call();
      } finally {
        if (context.mounted) {
          isLoadingMore.value = false;
        }
      }
    }

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        // 末尾に到達したら追加ロード
        final metrics = notification.metrics;
        final isScrollable = metrics.maxScrollExtent > 0;
        if (isScrollable && metrics.extentAfter == 0) {
          // 発火は非同期に実行してスクロール通知の再入を避ける
          Future<void>(handleLoadMore);
        }
        return false;
      },
      child: CustomScrollView(
        controller: controller,
        physics:
            physics ??
            const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
        slivers: [
          if (enableRefresh)
            CupertinoSliverRefreshControl(
              builder: refreshIndicatorBuilder ?? defaultRefreshBuilder,
              onRefresh: () async {
                if (onRefresh != null) {
                  await Future<void>.delayed(const Duration(milliseconds: 500));
                  await onRefresh!.call();
                }
              },
            ),

          // 呼び出し側の Sliver 群
          ...slivers,

          // Pagination インジケータ
          if (enablePagination)
            SliverPadding(
              padding: paginationPadding,
              sliver: SliverToBoxAdapter(
                child: Visibility(
                  visible: isLoadingMore.value,
                  child:
                      paginationIndicator ?? const CupertinoActivityIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
