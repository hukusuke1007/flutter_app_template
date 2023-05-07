import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../extensions/context_extension.dart';
import '../../../../../model/entities/sample/developer.dart';
import '../../../../../model/entities/sample/timeline/post.dart';
import '../../../../../model/use_cases/sample/auth/fetch_my_user_id.dart';
import '../../../../../model/use_cases/sample/timeline/fetch_poster.dart';
import '../../../../../utils/clipboard.dart';
import '../../../../widgets/buttons/ripple_tap_gesture.dart';
import '../../../../widgets/images/thumbnail.dart';
import '../enum/menu_result_type.dart';
import 'tile_menu.dart';

class TimelineTile extends HookConsumerWidget {
  const TimelineTile({
    required this.data,
    this.onTap,
    this.onTapAvatar,
    super.key,
  });

  final Post data;
  final VoidCallback? onTap;
  final void Function(Developer?)? onTapAvatar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poster = ref.watch(fetchPosterProviders(data.userId)).asData?.value;
    final myUserId = ref.watch(fetchMyUserIdProvider);
    final isMyData = myUserId != null && data.userId == myUserId;
    return RippleTapGesture(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 投稿者
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CircleThumbnail(
                          size: 48,
                          url: poster?.image?.url,
                          onTap: onTapAvatar != null
                              ? () {
                                  onTapAvatar!(poster);
                                }
                              : null,
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
                                    text: data.userId,
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
                                  data.dateLabel,
                                  style: context.smallStyle,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Builder(
                                builder: (context) {
                                  return TileMenu(
                                    data: data,
                                    isMyData: isMyData,
                                    onTapMenu: (result) async {
                                      if (result == MenuResultType.share) {
                                        final box = context.findRenderObject()
                                            as RenderBox?;
                                        if (box == null) {
                                          return;
                                        }
                                        unawaited(
                                          Share.share(
                                            data.text,
                                            sharePositionOrigin:
                                                box.localToGlobal(Offset.zero) &
                                                    box.size,
                                          ),
                                        );
                                      } else if (result ==
                                          MenuResultType.copy) {
                                        await Clipboard.copy(data.text);
                                        context.showSnackBar('コピーしました');
                                      } else if (result ==
                                          MenuResultType.issueReport) {
                                        unawaited(
                                          showOkAlertDialog(
                                            context: context,
                                            title: '実装してください',
                                          ),
                                        );
                                      } else if (result ==
                                          MenuResultType.mute) {
                                        unawaited(
                                          showOkAlertDialog(
                                            context: context,
                                            title: '実装してください',
                                          ),
                                        );
                                      } else if (result ==
                                          MenuResultType.block) {
                                        unawaited(
                                          showOkAlertDialog(
                                            context: context,
                                            title: '実装してください',
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
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
                  text: data.text,
                  style: context.bodyStyle,
                  maxLines: 4,
                  overflow: TextOverflow.fade,
                  linkStyle: context.bodyStyle.copyWith(color: Colors.blue),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
