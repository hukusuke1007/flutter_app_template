import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'image_viewer_header.dart';
import 'save_image_to_media_folder.dart';

class ImageViewer extends HookConsumerWidget {
  ImageViewer({
    required this.urls,
    required this.files,
    required this.assetNames,
    required this.initialPage,
    this.heroTag,
    super.key,
  }) : assert(urls.isNotEmpty || files.isNotEmpty || assetNames.isNotEmpty);

  static Future<void> show(
    BuildContext context, {
    List<String>? urls,
    List<File>? files,
    List<String>? assetNames,
    int initialPage = 0,
    String? heroTag,
    bool rootNavigator = true,
  }) =>
      context.pushTransparentRoute(
        ImageViewer(
          urls: urls ?? [],
          files: files ?? [],
          assetNames: assetNames ?? [],
          initialPage: initialPage,
          heroTag: heroTag,
        ),
        rootNavigator: true,
      );

  final List<String> urls;
  final List<File> files;
  final List<String> assetNames;
  final int initialPage;
  final String? heroTag;

  bool get isUrl => urls.isNotEmpty && files.isEmpty && assetNames.isEmpty;

  bool get isFile => urls.isEmpty && files.isNotEmpty && assetNames.isEmpty;

  bool get isAsset => urls.isEmpty && files.isEmpty && assetNames.isNotEmpty;

  int get count => files.isNotEmpty
      ? files.length
      : assetNames.isNotEmpty
          ? assetNames.length
          : urls.length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(initialPage);
    final controller =
        useState(ExtendedPageController(initialPage: initialPage));

    Widget extendedImageSlidePage() {
      return ExtendedImageSlidePage(
        // ignore: avoid_redundant_argument_values
        slideAxis: SlideAxis.both,
        // ignore: avoid_redundant_argument_values
        slideType: SlideType.onlyImage,
        onSlidingPage: print,
        slidePageBackgroundHandler: (Offset offset, Size size) {
          final opacity = offset.distance /
              (Offset(size.width, size.height).distance / 2.0);
          return Colors.black.withOpacity(1 - opacity);
        },
        child: ExtendedImageGesturePageView.builder(
          itemBuilder: (BuildContext context, int index) {
            Widget getExtendedImage() {
              if (isFile) {
                return ExtendedImage.file(
                  files[index],
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      inPageView: true,
                    );
                  },
                );
              }
              if (isAsset) {
                return ExtendedImage.asset(
                  assetNames[index],
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      inPageView: true,
                    );
                  },
                );
              }
              return ExtendedImage.network(
                urls[index],
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                cacheMaxAge: const Duration(days: 90),
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    inPageView: true,
                  );
                },
              );
            }

            return getExtendedImage();
          },
          itemCount: count,
          onPageChanged: (int index) {
            selectedIndex.value = index;
          },
          controller: controller.value,
          // ignore: avoid_redundant_argument_values
          scrollDirection: Axis.horizontal,
        ),
      );
    }

    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.down,
      // ignore: avoid_redundant_argument_values
      isFullScreen: true,
      child: Scaffold(
        body: Stack(
          children: [
            heroTag != null
                ? Hero(
                    tag: heroTag!,
                    child: extendedImageSlidePage(),
                  )
                : extendedImageSlidePage(),
            ImageViewerHeader(
              onMenuSelected: (value) async {
                if (value == 0) {
                  final index = selectedIndex.value;
                  final imageBytes = await Future(() async {
                    if (isUrl) {
                      return ExtendedNetworkImageProvider(
                        urls[index],
                        cache: true,
                      ).getNetworkImageData();
                    } else if (isAsset) {
                      return ExtendedAssetImageProvider(assetNames[index])
                          .rawImageData;
                    } else if (isFile) {
                      return ExtendedFileImageProvider(files[index])
                          .rawImageData;
                    }
                    return null;
                  });
                  if (imageBytes == null) {
                    return;
                  }
                  await ref.read(saveImageToMediaFolderProvider)(imageBytes);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
