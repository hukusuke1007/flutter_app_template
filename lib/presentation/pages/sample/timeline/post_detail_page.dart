import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../model/use_cases/sample/auth/fetch_my_user_id.dart';
import '../../../../model/use_cases/sample/timeline/fetch_poster.dart';
import '../../../../model/use_cases/sample/timeline/post/fetch_post.dart';
import '../../../../utils/clipboard.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../widgets/images/image_viewer.dart';
import '../../../widgets/images/thumbnail.dart';
import 'edit_post_page.dart';
import 'enum/menu_result_type.dart';
import 'timeline_page.dart';

class PostDetailPage extends HookConsumerWidget {
  const PostDetailPage({
    required this.args,
    super.key,
  });

  static String get pageName => 'post_detail';
  static String get pagePath => '${TimelinePage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(
    BuildContext context, {
    required FetchPostArgs args,
  }) {
    context.push(pagePath, extra: args);
  }

  /// 従来の画面遷移
  static Future<void> showNav1(
    BuildContext context, {
    required FetchPostArgs args,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => PostDetailPage(
          args: args,
        ),
      ),
    );
  }

  final FetchPostArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final asyncValue = ref.watch(fetchPostAsyncProviders(args));
    final data = asyncValue.asData?.value;

    final poster = ref.watch(fetchPosterProviders(args.userId)).asData?.value;
    final myUserId = ref.watch(fetchMyUserIdProvider);
    final isMyData =
        data != null && myUserId != null && data.userId == myUserId;

    useEffectOnce(() {
      Future(() async {
        final value = await ref.read(fetchPostAsyncProviders(args).future);
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
                    final box = context.findRenderObject() as RenderBox?;
                    if (box == null) {
                      return;
                    }
                    unawaited(
                      Share.share(
                        text,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size,
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
              onPressed: () {
                EditPostPage.push(
                  context,
                  args: EditPostPageArgs(
                    fetchPostArgs: args,
                    oldPost: data,
                  ),
                );
              },
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}
