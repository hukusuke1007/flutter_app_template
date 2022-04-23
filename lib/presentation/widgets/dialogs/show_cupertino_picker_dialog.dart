import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../../gen/colors.gen.dart';

Future<int?> showCupertinoPickerDialog(
  BuildContext context,
  List<String> list, {
  String doneText = '閉じる',
  required FixedExtentScrollController fixedExtentScrollController,
  void Function(int)? onChange,
}) async {
  const height = 240.0;
  return showModalBottomSheet<int?>(
    context: context,
    builder: (BuildContext builder) {
      return SizedBox(
        height: height + 40,
        child: Column(
          children: [
            SizedBox(
              width: context.deviceWidth,
              height: 40,
              child: ColoredBox(
                color: context.isDark ? Colors.black : Colors.white,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop<int>(fixedExtentScrollController.selectedItem);
                    },
                    child: Text(
                      doneText,
                      style:
                          context.bodyStyle.copyWith(color: ColorName.primary),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height,
              child: CupertinoPicker.builder(
                scrollController: fixedExtentScrollController,
                itemBuilder: (context, index) {
                  final data = list[index];
                  return Center(
                    child: Text(
                      data,
                      style: context.bodyStyle,
                    ),
                  );
                },
                childCount: list.length,
                itemExtent: 40,
                onSelectedItemChanged: onChange,
              ),
            ),
          ],
        ),
      );
    },
  );
}
