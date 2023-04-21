import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    required this.message,
    this.retryTitle = 'リトライ',
    required this.onRetry,
    super.key,
  });

  final String message;
  final String retryTitle;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: context.bodyStyle.copyWith(
            color: Colors.redAccent,
          ),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: onRetry,
          child: Text(
            retryTitle,
            style: context.bodyStyle.copyWith(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
