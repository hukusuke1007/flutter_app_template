import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';

Future<bool?> showDatePickerSheet(
  BuildContext context, {
  required DateTime date,
  required void Function(DateTime) onDateTimeChanged,
}) async {
  return showCupertinoModalPopup<bool?>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: Column(
          children: [
            ColoredBox(
              color: context.isDark ? Colors.black : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'キャンセル',
                      style: context.bodyStyle,
                      maxLines: 1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      '完了',
                      style: context.bodyStyle,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: CupertinoDatePicker(
                backgroundColor: context.isDark ? Colors.black : Colors.white,
                initialDateTime: date,
                maximumYear: DateTime.now().year,
                onDateTimeChanged: onDateTimeChanged,
                minimumYear: 1900,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
          ],
        ),
      );
    },
  );
}
