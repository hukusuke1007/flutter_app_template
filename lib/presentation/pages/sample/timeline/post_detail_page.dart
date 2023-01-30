import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/entities/sample/enum/operation_type.dart';
import 'package:flutter_app_template/presentation/custom_hooks/use_effect_once.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../model/use_cases/sample/my_profile/fetch_my_profile.dart';
import '../../../../model/use_cases/sample/timeline/fetch_poster.dart';
import '../../../../model/use_cases/sample/timeline/post/fetch_post.dart';
import '../../../../utils/clipboard.dart';
import '../../../widgets/thumbnail.dart';
import 'edit_post_page.dart';
import 'enum/menu_result_type.dart';

class PostDetailPage extends HookConsumerWidget {
  const PostDetailPage({
    required this.param,
    super.key,
  });

  static String get pageName => 'post_detail';
  static String get pagePath => '/$pageName';

  static Future<void> show(
    BuildContext context, {
    required FetchPostParam param,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        builder: (_) => PostDetailPage(
          param: param,
        ),
      ),
    );
  }

  final FetchPostParam param;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final asyncValue = ref.watch(fetchPostAsyncProviders(param));
    final data = asyncValue.value;

    final poster = ref.watch(fetchPosterProviders(param.userId)).value;
    final myProfile = ref.watch(fetchMyProfileProvider).value;
    final isMyData = data != null &&
        myProfile != null &&
        data.userId == myProfile.developerId;

    useEffectOnce(() {
      Future(() async {
        final value = await ref.read(fetchPostAsyncProviders(param).future);
        if (value == null) {
          await showOkAlertDialog(
            context: context,
            title: '投稿が削除されています',
          );
          Navigator.pop(context);
        }
      });
      return null;
    });

    return GestureDetector(
      onTap: context.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '投稿内容',
            style: context.subtitleStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<MenuResultType>(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  MenuResultType.share,
                  MenuResultType.copy,
                  if (!isMyData) MenuResultType.issueReport,
                ]
                    .map(
                      (data) => PopupMenuItem<MenuResultType>(
                        value: data,
                        child: Text(
                          data.label,
                          style: context.bodyStyle,
                        ),
                      ),
                    )
                    .toList();
              },
              onSelected: (result) async {
                final text = data?.text;
                if (text == null) {
                  return;
                }

                if (result == MenuResultType.share) {
                  unawaited(Share.share(text));
                } else if (result == MenuResultType.copy) {
                  unawaited(Clipboard.copy(text));
                  context.showSnackBar('コピーしました');
                } else if (result == MenuResultType.issueReport) {
                  // TODO(shohei): 未実装
                }
              },
            ),
          ],
        ),
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 投稿者
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CircleThumbnail(
                                size: 48,
                                url: poster?.image?.url,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: poster?.name ?? '投稿者',
                                          style: context.bodyStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: poster?.developerId ?? '-',
                                          style: context.smallStyle,
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 48,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        data?.dateLabel ?? '-',
                                        style: context.smallStyle,
                                        maxLines: 2,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// テキスト
                      Linkify(
                        onOpen: (link) {
                          launchUrlString(
                            link.url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        text: data?.text ?? '',
                        style: context.bodyStyle,
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                        linkStyle:
                            context.bodyStyle.copyWith(color: Colors.blue),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),
              ],
            ),
          ),
        ),
        floatingActionButton: isMyData
            ? FloatingActionButton(
                onPressed: () async {
                  final result = await EditPostPage.show(
                    context,
                    oldPost: data,
                  );
                  final operationType = result?.operationType;
                  if (operationType == null) {
                    return;
                  }

                  if (operationType == OperationType.update) {
                    ref.invalidate(fetchPostAsyncProviders(param));
                  } else if (operationType == OperationType.delete) {
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.edit),
              )
            : null,
      ),
    );
  }
}
