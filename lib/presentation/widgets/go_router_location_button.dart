import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterLocationButton extends StatelessWidget {
  const GoRouterLocationButton({
    Key? key,
    required this.child,
    this.visible = true,
  }) : super(key: key);

  final Widget child;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return child;
    }
    final router = GoRouter.of(context);
    final location = router.location;
    return Stack(
      children: [
        child,
        Positioned(
          right: 0,
          top: 50,
          child: SafeArea(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () async {
                final next = (await showTextInputDialog(
                  context: router.navigator!.context,
                  textFields: [
                    DialogTextField(initialText: location),
                  ],
                ))
                    ?.first;
                if (next != null) {
                  router.go(next);
                }
              },
              child: Text(location),
            ),
          ),
        ),
      ],
    );
  }
}
