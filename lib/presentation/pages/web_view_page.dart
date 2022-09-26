import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../extensions/context_extension.dart';
import '../../utils/clipboard.dart';
import '../../utils/logger.dart';

@immutable
class WebViewArgs {
  const WebViewArgs({
    required this.url,
    this.title = '',
  });
  final String url;
  final String title;
}

class WebViewPage extends HookConsumerWidget {
  const WebViewPage(
    this.args, {
    super.key,
  });

  static String get pageName => 'web_view_page';
  static String get pagePath => '/$pageName';

  final WebViewArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleState = useState<String>(args.title);
    final urlState = useState(args.url);
    final progress = useState<double>(0);
    final webViewController = useState<InAppWebViewController?>(null);

    final pullToRefreshController = useState(
      PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.blue),
        onRefresh: () async {
          if (Platform.isAndroid) {
            await webViewController.value?.reload();
          } else if (Platform.isIOS) {
            await webViewController.value?.loadUrl(
              urlRequest:
                  URLRequest(url: await webViewController.value?.getUrl()),
            );
          }
        },
      ),
    );

    final mounted = useIsMounted();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleState.value,
          style: context.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 1,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              final list = [
                'URLをコピーする',
                'URLを共有する',
                'ブラウザで開く',
              ];

              return list
                  .mapIndexed(
                    (index, data) => PopupMenuItem<int>(
                      value: index,
                      child: Text(
                        data,
                        style: context.bodyStyle,
                      ),
                    ),
                  )
                  .toList();
            },
            onSelected: (value) async {
              if (value == 0) {
                final value = await webViewController.value?.getUrl();
                if (value == null) {
                  return;
                }
                await Clipboard.copy(value.toString());
                context.showSnackBar('URLをコピーしました');
              } else if (value == 1) {
                unawaited(Share.share(urlState.value));
              } else if (value == 2) {
                final uri = Uri.parse(urlState.value);
                if (!await canLaunchUrl(uri)) {
                  return;
                }
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(urlState.value)),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                      displayZoomControls: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    ),
                  ),
                  pullToRefreshController: pullToRefreshController.value,
                  onWebViewCreated: (controller) {
                    webViewController.value = controller;
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT,
                    );
                  },
                  onProgressChanged: (controller, value) {
                    progress.value = value / 100;
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    logger.info(consoleMessage);
                  },
                  onLoadStart: (_, url) {
                    urlState.value = url?.toString() ?? '';
                  },
                  onLoadStop: (controller, _) async {
                    if (!mounted()) {
                      return;
                    }
                    titleState.value =
                        (await webViewController.value?.getTitle()) ?? '';

                    await pullToRefreshController.value.endRefreshing();
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      webViewController.value?.goBack();
                    },
                  ),
                  Expanded(
                    child: Text(
                      urlState.value,
                      style: context.smallStyle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 24,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      webViewController.value?.goForward();
                    },
                  ),
                ],
              ),
            ],
          ),
          if (progress.value < 1.0)
            Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(value: progress.value),
            ),
        ],
      ),
    );
  }
}
