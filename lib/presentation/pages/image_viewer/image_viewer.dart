import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_transition/page_transition.dart';

import 'image_viewer_header.dart';
import 'save_image_to_media_folder.dart';

class ImageViewer extends HookWidget {
  ImageViewer({
    required this.urls,
    required this.files,
    required this.assetNames,
    required this.initialPage,
    Key? key,
  })  : assert(urls.isNotEmpty || files.isNotEmpty || assetNames.isNotEmpty),
        super(key: key);

  static Future<void> show(
    BuildContext context, {
    List<String>? urls,
    List<File>? files,
    List<String>? assetNames,
    int initialPage = 0,
    bool rootNavigator = true,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: ImageViewer(
          urls: urls ?? [],
          files: files ?? [],
          assetNames: assetNames ?? [],
          initialPage: initialPage,
        ),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  final List<String> urls;
  final List<File> files;
  final List<String> assetNames;
  final int initialPage;

  bool get isUrl => urls.isNotEmpty && files.isEmpty && assetNames.isEmpty;

  bool get isFile => urls.isEmpty && files.isNotEmpty && assetNames.isEmpty;

  bool get isAsset => urls.isEmpty && files.isEmpty && assetNames.isNotEmpty;

  int get count => files.isNotEmpty
      ? files.length
      : assetNames.isNotEmpty
          ? assetNames.length
          : urls.length;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(initialPage);
    final controller =
        useState(ExtendedPageController(initialPage: initialPage));
    return Scaffold(
      body: Stack(
        children: [
          ExtendedImageSlidePage(
            slideAxis: SlideAxis.both,
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
                          initialScale: 1,
                          cacheGesture: false,
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
                          initialScale: 1,
                          cacheGesture: false,
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
                        initialScale: 1,
                        cacheGesture: false,
                      );
                    },
                  );
                }

                return GestureDetector(
                  child: getExtendedImage(),
                  onVerticalDragEnd: (details) {
                    final velocity = details.primaryVelocity;
                    if (velocity != null && velocity > 0) {
                      Navigator.pop(context);
                    }
                  },
                );
              },
              itemCount: count,
              onPageChanged: (int index) {
                selectedIndex.value = index;
              },
              controller: controller.value,
              scrollDirection: Axis.horizontal,
            ),
          ),
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
                    return ExtendedFileImageProvider(files[index]).rawImageData;
                  }
                  return null;
                });
                if (imageBytes == null) {
                  return;
                }
                await saveImageToMediaFolder(context, imageBytes);
              }
            },
          ),
        ],
      ),
    );
  }
}
