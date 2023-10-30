import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/custom_hooks/use_effect_once.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/selectable_linkify_extension.dart';
import '../../../../core/extensions/share_extension.dart';
import '../../../../core/utils/clipboard.dart';
import '../../../../core/widgets/images/image_viewer.dart';
import '../../../../core/widgets/images/thumbnail.dart';
import '../enum/menu_result_type.dart';
import '../use_cases/fetch_my_user_id.dart';
import '../use_cases/fetch_poster.dart';
import '../use_cases/post_controller.dart';
import 'edit_post_page.dart';
import 'timeline_page.dart';

class PostDetailPage extends HookConsumerWidget {
  const PostDetailPage({
    required this.posterId,
    required this.postId,
    super.key,
  });

  static String get pageName => 'post_detail';
  static String get pagePath => '${TimelinePage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(
    BuildContext context, {
    required String posterId,
    required String postId,
  }) {
    context.push(pagePath, extra: (posterId, postId));
  }

  /// 従来の画面遷移
  static Future<void> showNav1(
    BuildContext context, {
    required String posterId,
    required String postId,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => PostDetailPage(
          posterId: posterId,
          postId: postId,
        ),
      ),
    );
  }

  final String posterId;
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final provider = postControllerProvider(posterId: posterId, postId: postId);
    final data = ref.watch(provider).asData?.value;

    final poster = ref.watch(fetchPosterProvider(posterId)).asData?.value;

    final myUserId = ref.watch(fetchMyUserIdProvider);
    final isMyData =
        data != null && myUserId != null && data.userId == myUserId;

    useEffectOnce(() {
      Future.microtask(() async {
        final value = await ref.read(provider.future);
        if (value == null) {
          await showOkAlertDialog(
            context: context,
            title: '投稿が削除されています',
          );
          context.pop();
        }
      });
      return null;
    });

    return Scaffold(
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
          Builder(
            builder: (context) {
              return PopupMenuButton<MenuResultType>(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    MenuResultType.share,
                    MenuResultType.copy,
                    if (!isMyData) ...[
                      MenuResultType.issueReport,
                      MenuResultType.mute,
                      MenuResultType.block,
                    ],
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
                    unawaited(
                      ShareExtension.shareText(
                        context,
                        text,
                      ),
                    );
                  } else if (result == MenuResultType.copy) {
                    unawaited(Clipboard.copy(text));
                    context.showSnackBar('コピーしました');
                  } else if (result == MenuResultType.issueReport) {
                    unawaited(
                      showOkAlertDialog(context: context, title: '実装してください'),
                    );
                  } else if (result == MenuResultType.mute) {
                    unawaited(
                      showOkAlertDialog(context: context, title: '実装してください'),
                    );
                  } else if (result == MenuResultType.block) {
                    unawaited(
                      showOkAlertDialog(context: context, title: '実装してください'),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 投稿者
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                            onTap: () {
                              final url = poster?.image?.url;
                              if (url != null) {
                                ImageViewer.show(
                                  context,
                                  urls: [url],
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: poster?.name ?? '投稿者',
                                      style: context.bodyStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 3,
                                textAlign: TextAlign.left,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: data?.userId ?? '-',
                                      style: context.smallStyle,
                                    ),
                                  ],
                                ),
                                maxLines: 1,
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
                  SelectableLinkify(
                    onOpen: (link) {
                      launchUrlString(
                        link.url,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    text: data?.text ?? '',
                    style: context.bodyStyle,
                    linkStyle: context.bodyStyle.copyWith(color: Colors.blue),
                    contextMenuBuilder:
                        SelectableLinkifyExtension.defaultContextMenuBuilder,
                  ),
                ],
              ),
            ),

            const Divider(height: 1),
          ],
        ),
      ),
      floatingActionButton: isMyData
          ? FloatingActionButton(
              onPressed: () {
                EditPostPage.push(
                  context,
                  args: EditPostPageArgs(
                    posterId: posterId,
                    postId: postId,
                  ),
                );
              },
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}
