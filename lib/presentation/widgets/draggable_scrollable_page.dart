// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';

class DraggableScrollablePage extends StatefulWidget {
  const DraggableScrollablePage({
    required this.heroTag,
    required this.pageBuilder,
    this.dismissThresholdRate = 0.72,
    this.scaleDownOffset = 60.0,
    this.enableBlur = true,
    this.blurSigma = 7,
    this.color,
    this.onDragVertical,
    super.key,
  });

  final String heroTag;
  final Widget Function(ScrollController scrollController) pageBuilder;
  final double dismissThresholdRate;
  final double scaleDownOffset;
  final bool enableBlur;
  final double blurSigma;
  final Color? color;
  final void Function(double margin, bool isScaleDown)? onDragVertical;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DraggableScrollablePage> {
  final ScrollController _scrollController = ScrollController();

  double _top = 0;
  double _bottom = 0;
  double _right = 0;
  double _left = 0;

  bool _isScaleDown = false;
  bool _isLock = false;
  double _opacity = 1;

  double get _dismissThresholdRate => widget.dismissThresholdRate;
  double get _scaleDownOffset => widget.scaleDownOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.addListener(() {
        final pixels = _scrollController.position.pixels;
        // ignore: invalid_use_of_protected_member
        final velocity = _scrollController.position.activity?.velocity ?? 0;
        // print(pixels);
        final margin = () {
          if (velocity != 0.0) {
            return 0.0;
          }
          if (pixels >= 0 || (0.0 > pixels && pixels > -_scaleDownOffset)) {
            return 0.0;
          }
          return -pixels - _scaleDownOffset;
        }();

        setState(() {
          _isScaleDown = margin != 0;
          _top = margin;

          /// BouncingScrollPhysicsの影響でひっぱった時にtopが大きくなるためbottomを余分に加算する
          _bottom = margin * 4;

          _right = margin;
          _left = margin;
        });

        if (widget.onDragVertical != null) {
          widget.onDragVertical!(margin, _isScaleDown);
        }

        final deviceWidth = context.deviceWidth;
        final bodyWidth = deviceWidth - margin * 2;
        final widthRate = bodyWidth / deviceWidth;
        // print('deviceWidth $deviceWidth, margin: $margin, rate: $widthRate');

        if (!_isLock) {
          setState(() {
            _opacity = widthRate == 1.0 ? widthRate : max(widthRate - 0.5, 0.2);
          });
          if (widthRate <= _dismissThresholdRate) {
            _isLock = true;
            Navigator.pop(context);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color != null
          ? widget.color!.withOpacity(_opacity)
          : context.scaffoldBackgroundColor.withOpacity(_opacity),
      body: Stack(
        children: [
          if (widget.enableBlur)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blurSigma,
                  sigmaY: widget.blurSigma,
                ),
                child: const SizedBox.shrink(),
              ),
            ),
          Positioned(
            top: _top,
            bottom: _bottom,
            right: _right,
            left: _left,
            child: Hero(
              tag: widget.heroTag,
              child: Material(
                color: Colors.transparent,
                child: Scrollbar(
                  thickness: _isScaleDown ? 0 : 3,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics:
                        Theme.of(context).platform == TargetPlatform.android
                            ? const BouncingScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                    child: widget.pageBuilder(_scrollController),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
