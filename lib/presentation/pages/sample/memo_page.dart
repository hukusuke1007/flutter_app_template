import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';
import '../../../model/use_cases/sample/memo_controller.dart';
import '../../../utils/logger.dart';
import '../../widgets/smart_refresher_custom.dart';
import 'edit_memo_dialog.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshController = useState(RefreshController());
    final items = ref.watch(memoProvider);

    useEffect(() {
      Future(() async {
        try {
          await ref.read(memoProvider.notifier).fetch();
        } on Exception catch (e) {
          logger.shout(e);
          context.showSnackBar(
            e.errorMessage,
            backgroundColor: Colors.grey,
          );
        }
      });
      return null;
    }, const []);

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
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController.value,
        physics: const BouncingScrollPhysics(),
        onRefresh: () async {
          try {
            await ref.read(memoProvider.notifier).fetch();
          } on Exception catch (e) {
            logger.shout(e);
            context.showSnackBar(
              e.errorMessage,
              backgroundColor: Colors.grey,
            );
          }
          refreshController.value.refreshCompleted();
        },
        onLoading: () async {
          try {
            await ref.read(memoProvider.notifier).fetchMore();
          } on Exception catch (e) {
            logger.shout(e);
            context.showSnackBar(
              e.errorMessage,
              backgroundColor: Colors.grey,
            );
          }
          refreshController.value.loadComplete();
        },
        child: ListView.separated(
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
                      final result = await showOkCancelAlertDialog(
                          context: context, title: '削除しますか？');
                      if (result == OkCancelResult.cancel) {
                        return;
                      }
                      try {
                        await ref.read(memoProvider.notifier).remove(docId);
                        context.showSnackBar('削除しました');
                      } on Exception catch (e) {
                        logger.shout(e);
                        context.showSnackBar(
                          e.errorMessage,
                          backgroundColor: Colors.grey,
                        );
                      }
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
