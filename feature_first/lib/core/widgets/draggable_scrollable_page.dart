import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

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
  final _scrollController = ScrollController();

  /// 縮小率。1.0で等倍、小さくなるほど縮む。
  ///
  /// setStateではなくValueNotifierで通知することで、スクロール中に
  /// BackdropFilterやスクロール本体まで作り直さないようにしている。
  final _scale = ValueNotifier<double>(1);

  var _isLock = false;

  double get _dismissThresholdRate => widget.dismissThresholdRate;
  double get _scaleDownOffset => widget.scaleDownOffset;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _scale.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLock || !mounted || !_scrollController.hasClients) {
      return;
    }
    final position = _scrollController.position;
    final pixels = position.pixels;

    /// scaleDownOffset分は遊びとして縮小させず、それを超えた分だけ縮小に使う
    final margin = pixels >= -_scaleDownOffset ? 0.0 : -pixels - _scaleDownOffset;

    final deviceWidth = context.deviceWidth;
    final scale = (deviceWidth - margin * 2) / deviceWidth;
    _scale.value = scale;

    widget.onDragVertical?.call(margin, margin != 0);

    /// 指を離した後の慣性スクロールで閉じてしまわないよう、ドラッグ中のみ判定する
    /// (DragScrollActivityのvelocityは0、慣性中のBallisticScrollActivityは非0)
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final velocity = position.activity?.velocity ?? 0;
    if (velocity == 0.0 && scale <= _dismissThresholdRate) {
      _isLock = true;
      Navigator.pop(context);
    }
  }

  double _opacityOf(double scale) =>
      scale == 1.0 ? scale : max(scale - 0.5, 0.2);

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? context.scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: ValueListenableBuilder<double>(
              valueListenable: _scale,
              builder:
                  (context, scale, _) =>
                      ColoredBox(color: baseColor.withValues(alpha: _opacityOf(scale))),
            ),
          ),
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

          /// Positionedのinsetで縮めるとスクロールビューポート自体が縮み、
          /// BouncingScrollPhysicsの摩擦計算(viewportDimension依存)が毎フレーム変わって
          /// カクつき・閾値まで引っ張れない原因になるため、Transformで見た目だけ縮める
          Positioned.fill(
            child: ValueListenableBuilder<double>(
              valueListenable: _scale,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics:
                    Theme.of(context).platform == TargetPlatform.android
                        ? const BouncingScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                child: widget.pageBuilder(_scrollController),
              ),
              builder:
                  (context, scale, child) => Transform.scale(
                    scale: scale,
                    child: Hero(
                      tag: widget.heroTag,
                      child: Material(
                        color: Colors.transparent,
                        child: Scrollbar(
                          thickness: scale < 1.0 ? 0 : 3,
                          controller: _scrollController,
                          child: child!,
                        ),
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
