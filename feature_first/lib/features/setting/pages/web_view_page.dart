import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/share_extension.dart';
import '../../../core/utils/clipboard.dart';
import '../../../core/utils/logger.dart';

class WebViewArgs extends Equatable {
  const WebViewArgs({
    required this.url,
    this.title,
  });
  final String url;
  final String? title;

  @override
  List<Object?> get props => [url, title];
}

class WebViewPage extends HookConsumerWidget {
  const WebViewPage({
    super.key,
    required this.args,
  });

  static String get pageName => 'web_view';
  static String get pagePath => '/$pageName';

  /// go_routerの画面遷移
  static void push(
    BuildContext context, {
    required String url,
    String? title,
  }) {
    context.push(
      WebViewPage.pagePath,
      extra: WebViewArgs(
        url: url,
        title: title,
      ),
    );
  }

  /// 従来の画面遷移
  static Future<void> showNav1(
    BuildContext context, {
    required String url,
    String? title,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => WebViewPage(
          args: WebViewArgs(
            url: url,
            title: title,
          ),
        ),
      ),
    );
  }

  final WebViewArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleState = useState<String>(args.title ?? '');
    final urlState = useState(args.url);
    final progressState = useState<double>(0);
    final progress = progressState.value;
    final webViewController = useState<InAppWebViewController?>(null);

    final pullToRefreshController = useState(
      PullToRefreshController(
        settings: PullToRefreshSettings(
          color: Colors.blue,
        ),
        onRefresh: () async {
          if (Platform.isAndroid) {
            await webViewController.value?.reload();
          } else if (Platform.isIOS) {
            await webViewController.value?.loadUrl(
              urlRequest: URLRequest(
                url: await webViewController.value?.getUrl(),
              ),
            );
          }
        },
      ),
    );

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
        actions: [
          Builder(
            builder: (context) {
              return PopupMenuButton<int>(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                        'リンクをコピー',
                        'リンクを共有',
                        'ブラウザで開く',
                      ]
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
                    Clipboard.copy(value.toString()).ignore();
                    if (context.mounted) {
                      context.showSnackBar('URLをコピーしました');
                    }
                  } else if (value == 1) {
                    final box = context.findRenderObject() as RenderBox?;
                    if (box == null) {
                      return;
                    }

                    ShareExtension.shareText(
                      context,
                      urlState.value,
                    ).ignore();
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
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri(urlState.value),
                    ),
                    initialSettings: InAppWebViewSettings(
                      useHybridComposition: false,
                      displayZoomControls: true,
                      useShouldOverrideUrlLoading: true,
                    ),
                    pullToRefreshController: pullToRefreshController.value,
                    onWebViewCreated: (controller) {
                      webViewController.value = controller;
                    },
                    onPermissionRequest: (controller, request) async {
                      return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT,
                      );
                    },
                    onProgressChanged: (controller, value) {
                      if (context.mounted) {
                        progressState.value = value / 100;
                      }
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      logger.info(consoleMessage);
                    },
                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      // https://github.com/pichillilorenzo/flutter_inappwebview/blob/master/flutter_inappwebview/example/lib/in_app_webiew_example.screen.dart#L141
                      final uri = navigationAction.request.url;
                      if (uri != null) {
                        if (![
                          'http',
                          'https',
                          'file',
                          'chrome',
                          'data',
                          'javascript',
                          'about',
                        ].contains(uri.scheme)) {
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);

                            return NavigationActionPolicy.CANCEL;
                          }
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStart: (_, url) {
                      urlState.value = url?.toString() ?? '';
                    },
                    onLoadStop: (controller, _) async {
                      if (!context.mounted) {
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
            if (progress < 1.0)
              Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(value: progress),
              ),
          ],
        ),
      ),
    );
  }
}
