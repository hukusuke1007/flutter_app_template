import 'package:flutter/material.dart';

import '../../../../../extensions/context_extension.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        'パスワードを忘れた',
        style: context.bodyStyle.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
