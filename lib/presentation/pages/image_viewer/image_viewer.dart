import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_transition/page_transition.dart';

import 'image_viewer_header.dart';
import 'save_image_to_media_folder.dart';

class ImageViewer extends StatefulHookWidget {
  ImageViewer({
    required this.urls,
    required this.files,
    required this.assetNames,
    Key? key,
  })  : assert(urls.isNotEmpty || files.isNotEmpty || assetNames.isNotEmpty),
        super(key: key);

  static Future<void> show(
    BuildContext context, {
    List<String>? urls,
    List<File>? files,
    List<String>? assetNames,
    bool rootNavigator = true,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: ImageViewer(
          urls: urls ?? [],
          files: files ?? [],
          assetNames: assetNames ?? [],
        ),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  final List<String> urls;
  final List<File> files;
  final List<String> assetNames;

  @override
  _State createState() => _State();
}

class _State extends State<ImageViewer> {
  int _selectedIndex = 0;

  bool get isUrl =>
      widget.urls.isNotEmpty &&
      widget.files.isEmpty &&
      widget.assetNames.isEmpty;

  bool get isFile =>
      widget.urls.isEmpty &&
      widget.files.isNotEmpty &&
      widget.assetNames.isEmpty;

  bool get isAsset =>
      widget.urls.isEmpty &&
      widget.files.isEmpty &&
      widget.assetNames.isNotEmpty;

  int get count => widget.files.isNotEmpty
      ? widget.files.length
      : widget.assetNames.isNotEmpty
          ? widget.assetNames.length
          : widget.urls.length;

  @override
  Widget build(BuildContext context) {
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
                      widget.files[index],
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
                      widget.assetNames[index],
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
                    widget.urls[index],
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
                _selectedIndex = index;
              },
              controller: ExtendedPageController(initialPage: 0),
              scrollDirection: Axis.horizontal,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: 1,
            child: ImageViewerHeader(
              onMenuSelected: _selectedIndex == 0
                  ? (value) async {
                      if (value == 0) {
                        final imageBytes = await Future(() async {
                          if (isUrl) {
                            return ExtendedNetworkImageProvider(
                              widget.urls[_selectedIndex],
                              cache: true,
                            ).getNetworkImageData();
                          } else if (isAsset) {
                            return ExtendedAssetImageProvider(
                                    widget.assetNames[_selectedIndex])
                                .rawImageData;
                          } else if (isFile) {
                            return ExtendedFileImageProvider(
                                    widget.files[_selectedIndex])
                                .rawImageData;
                          }
                          return null;
                        });
                        if (imageBytes == null) {
                          return;
                        }
                        await saveImageToMediaFolder(context, imageBytes);
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
