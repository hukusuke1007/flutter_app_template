import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/presentation/custom_hooks/use_effect_once.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../gen/assets.gen.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({
    required this.heroTag,
    // required this.scrollController,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  // final ScrollController scrollController;

  static void show(
    BuildContext context, {
    required String heroTag,
  }) {
    context.pushTransparentRoute(
      DetailPage(
        heroTag: heroTag,
      ),
      rootNavigator: true,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    /// ClampingScrollPhysicsにした方が良いかも
    final physicsState = useState<ScrollPhysics>(const BouncingScrollPhysics());

    final topState = useState<double>(0);
    final bottomState = useState<double>(0);
    final rightState = useState<double>(0);
    final leftState = useState<double>(0);
    final isLockState = useState<bool>(false);

    useEffectOnce(() {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (!scrollController.hasClients) {
          return;
        }
        scrollController.addListener(() {
          final pixels = scrollController.position.pixels;
          print(pixels);
          final margin = () {
            const offset = 50.0;
            if (pixels >= 0) {
              return 0.0;
            } else if (0.0 > pixels && pixels > -offset) {
              return 0.0;
            }
            return -pixels - offset;
          }();

          print(margin);
          topState.value = margin;
          bottomState.value = margin;
          rightState.value = margin;
          leftState.value = margin;
          if (margin >= 80 && !isLockState.value) {
            isLockState.value = true;
            Navigator.pop(context);
          }
        });
      });
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: topState.value,
            bottom: bottomState.value,
            right: rightState.value,
            left: leftState.value,
            child: Hero(
              tag: heroTag,
              child: _Home(
                heroTag: heroTag,
                physics: physicsState.value,
                scrollController: scrollController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    required this.heroTag,
    this.physics,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  final ScrollPhysics? physics;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: physics,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Image.asset(
                      Assets.neko.assetName,
                      fit: BoxFit.fitHeight,
                      height: 300,
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n'
                  'にゃーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー\n',
                  style: context.bodyStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
