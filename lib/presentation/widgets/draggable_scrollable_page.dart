import 'dart:math';

import 'package:flutter/material.dart';

class DraggableScrollablePage extends StatefulWidget {
  const DraggableScrollablePage({
    required this.heroTag,
    required this.child,
    this.dismissThresholdRate = 0.72,
    this.scaleDownOffset = 60.0,
    this.color = Colors.white,
    this.onDragVertical,
    this.scrollController,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  final Widget child;
  final double dismissThresholdRate;
  final double scaleDownOffset;
  final Color color;
  final ScrollController? scrollController;
  final void Function(double margin, bool isScaleDown)? onDragVertical;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DraggableScrollablePage> {
  late final ScrollController _scrollController =
      widget.scrollController ?? ScrollController();

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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.addListener(() {
        final pixels = _scrollController.position.pixels;
        // TODO(shohei): 警告が気になる
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
          _bottom = margin;
          _right = margin;
          _left = margin;
        });

        if (widget.onDragVertical != null) {
          widget.onDragVertical!(margin, _isScaleDown);
        }

        final deviceWidth = MediaQuery.of(context).size.width;
        final bodyWidth = deviceWidth - margin * 2;
        final widthRate = bodyWidth / deviceWidth;
        // print('deviceWidth $deviceWidth, margin: $margin, rate: $widthRate');

        if (!_isLock) {
          setState(() {
            _opacity = widthRate == 1.0 ? widthRate : max(widthRate - 0.8, 0);
          });
          if (widthRate <= _dismissThresholdRate) {
            _isLock = true;
            setState(() {
              _opacity = 0.0;
            });
            Navigator.pop(context);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color.withOpacity(_opacity),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            bottom: _bottom,
            right: _right,
            left: _left,
            child: Hero(
              tag: widget.heroTag,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Scrollbar(
                  thickness: _isScaleDown ? 0 : 3,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    child: widget.child,
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
