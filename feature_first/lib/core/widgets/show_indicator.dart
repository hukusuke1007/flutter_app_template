import 'package:flutter/material.dart';

void showIndicator(BuildContext context) => showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

void dismissIndicator(BuildContext context) =>
    Navigator.of(context, rootNavigator: true).pop();
