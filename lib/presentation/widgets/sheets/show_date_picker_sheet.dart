import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';

Future<void> showDatePickerSheet(
  BuildContext context, {
  required DateTime date,
  required void Function(DateTime) onDateTimeChanged,
}) async {
  return showCupertinoModalPopup(
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('キャンセル'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('完了'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
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
