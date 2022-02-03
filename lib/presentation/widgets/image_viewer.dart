import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_transition/page_transition.dart';

class ImageViewer extends StatefulHookWidget {
  const ImageViewer({
    required this.urls,
    required this.files,
    required this.assetNames,
    Key? key,
  }) : super(key: key);

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
  Offset beginningDragPosition = Offset.zero;
  Offset currentDragPosition = Offset.zero;
  int photoViewAnimationDurationMilliSec = 0;
  double barsOpacity = 1;

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

  double get photoViewScale {
    return max(1.0 - currentDragPosition.distance * 0.001, 0.8);
  }

  double get photoViewOpacity {
    return max(1.0 - currentDragPosition.distance * 0.005, 0.1);
  }

  Matrix4 get photoViewTransform {
    final translationTransform = Matrix4.translationValues(
      currentDragPosition.dx,
      currentDragPosition.dy,
      0,
    );

    final scaleTransform = Matrix4.diagonal3Values(
      photoViewScale,
      photoViewScale,
      1,
    );

    return translationTransform.multiplied(scaleTransform);
  }

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
                // nothing
              },
              controller: ExtendedPageController(initialPage: 0),
              scrollDirection: Axis.horizontal,
            ),
          ),
          _buildTopBar(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    const topBarHeight = 100.0;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: barsOpacity,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        height: topBarHeight,
        child: Column(
          children: [
            Container(height: statusBarHeight),
            SizedBox(
              height: topBarHeight - statusBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white.withOpacity(0.8),
                        size: 26,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapPhotoView() {
    setState(() {
      barsOpacity = (barsOpacity <= 0.0) ? 1.0 : 0.0;
    });
  }

  void onVerticalDragStart(DragStartDetails details) {
    setState(() {
      barsOpacity = 0.0;
      photoViewAnimationDurationMilliSec = 0;
    });
    beginningDragPosition = details.globalPosition;
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      barsOpacity = (currentDragPosition.distance < 20.0) ? 1.0 : 0.0;
      currentDragPosition = Offset(
        details.globalPosition.dx - beginningDragPosition.dx,
        details.globalPosition.dy - beginningDragPosition.dy,
      );
    });
  }

  void onVerticalDragEnd(DragEndDetails details) {
    if (currentDragPosition.distance < 100.0) {
      setState(() {
        photoViewAnimationDurationMilliSec = 200;
        currentDragPosition = Offset.zero;
        barsOpacity = 1.0;
      });
    } else {
      Navigator.of(context).pop();
    }
  }
}
