import 'package:flutter/material.dart';

import '../../../../../extensions/context_extension.dart';
import '../../../../../utils/clipboard.dart';
import '../../../../widgets/buttons/ripple_tap_gesture.dart';

class CurrentEmailAddressText extends StatelessWidget {
  const CurrentEmailAddressText({
    this.title = '現在のメールアドレス',
    required this.email,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final String title;
  final String email;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            RippleTapGesture(
              onTap: () {
                Clipboard.copy(email);
                context.showSnackBar('メールアドレスをコピーしました');
              },
              child: Text(
                email,
                style: context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
