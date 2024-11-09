import 'package:flutter/material.dart';

void showIndicator(BuildContext context) => showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

void dismissIndicator(BuildContext context) =>
    Navigator.of(context, rootNavigator: true).pop();
