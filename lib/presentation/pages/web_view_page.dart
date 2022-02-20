import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../extensions/context_extension.dart';
import '../../utils/clipboard.dart';
import '../../utils/logger.dart';

class WebViewPage extends HookConsumerWidget {
  const WebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  static String get screenName => 'WebViewPage';

  static Future<void> show(
    BuildContext context, {
    required String url,
  }) {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute(
        builder: (_) => WebViewPage(
          url: url,
        ),
      ),
    );
  }

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleState = useState<String>('');
    final urlState = useState(url);
    final progress = useState<double>(0);
    final webViewController = useState<InAppWebViewController?>(null);

    final pullToRefreshController = useState(PullToRefreshController(
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
    ));

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              final list = [
                {'id': 0, 'text': 'URLをコピーする'},
                {'id': 1, 'text': 'ブラウザで開く'},
              ];
              return list
                  .map(
                    (data) => PopupMenuItem<int>(
                      value: data['id']! as int,
                      child: Text(data['text']! as String),
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
                await launch(
                  url,
                  forceSafariVC: false,
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
                  initialUrlRequest: URLRequest(url: Uri.parse(url)),
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
              SizedBox(
                width: context.deviceWidth,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          webViewController.value?.goBack();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        urlState.value,
                        style: context.smallStyle,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    ),
                    Flexible(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 24,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          webViewController.value?.goForward();
                        },
                      ),
                    ),
                  ],
                ),
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
