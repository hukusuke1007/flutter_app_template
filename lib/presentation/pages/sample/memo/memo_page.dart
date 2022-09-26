import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../model/use_cases/sample/memo_controller.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../custom_hooks/use_refresh_controller.dart';
import '../../../widgets/smart_refresher_custom.dart';
import 'show_edit_memo_dialog.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({super.key});

  static String get pageName => 'memo_page';
  static String get pagePath => '/$pageName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(memoProvider);
    final scrollController = useScrollController();

    final refreshController = useRefreshController();

    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(memoProvider.notifier).fetch();
        result.when(
          success: () {},
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
      body: SmartRefresher(
        header: const SmartRefreshHeader(),
        footer: const SmartRefreshFooter(),
        // ignore: avoid_redundant_argument_values
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController,
        physics: const BouncingScrollPhysics(),
        onRefresh: () async {
          final result = await ref.read(memoProvider.notifier).fetch();
          result.when(
            success: () {},
            failure: (e) {
              context.showSnackBar(
                e.errorMessage,
                backgroundColor: Colors.grey,
              );
            },
          );
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          final result = await ref.read(memoProvider.notifier).fetchMore();
          result.when(
            success: () {},
            failure: (e) {
              context.showSnackBar(
                e.errorMessage,
                backgroundColor: Colors.grey,
              );
            },
          );
          refreshController.loadComplete();
        },
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            final data = items[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) async {
                      final docId = data.memoId;
                      if (docId == null) {
                        return;
                      }
                      final alertResult = await showOkCancelAlertDialog(
                        context: context,
                        title: '削除しますか？',
                      );
                      if (alertResult == OkCancelResult.cancel) {
                        return;
                      }
                      final result =
                          await ref.read(memoProvider.notifier).remove(docId);
                      result.when(
                        success: () {
                          context.showSnackBar('削除しました');
                        },
                        failure: (e) {
                          context.showSnackBar(
                            e.errorMessage,
                            backgroundColor: Colors.grey,
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: '削除',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  data.text ?? '',
                  style: context.bodyStyle,
                ),
                trailing: Text(
                  data.dateLabel,
                  style: context.smallStyle,
                ),
                onTap: () {
                  showEditMemoDialog(context, data: data);
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
          itemCount: items.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditMemoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
