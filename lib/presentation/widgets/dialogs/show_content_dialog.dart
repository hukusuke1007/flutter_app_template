import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';

Future<T?> showContentDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required Widget contentWidget,
}) {
  return showDialog<T?>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => GestureDetector(
      onTap: context.hideKeyboard,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        content: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  contentWidget,
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      '閉じる',
                      style: context.bodyStyle.copyWith(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
