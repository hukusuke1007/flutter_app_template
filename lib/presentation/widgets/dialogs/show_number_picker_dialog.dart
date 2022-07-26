import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../extensions/context_extension.dart';
import '../../../gen/colors.gen.dart';

Future<void> showDecimalPickerDialog(
  BuildContext context,
  double currentValue, {
  required int minValue,
  required int maxValue,
  String doneText = '決定',
  required void Function(double) onChange,
}) async {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext builder) {
      return DecimalPicker(
        height: 240,
        initialValue: currentValue,
        doneText: doneText,
        minValue: minValue,
        maxValue: maxValue,
        onChange: onChange,
      );
    },
  );
}

class DecimalPicker extends StatefulWidget {
  const DecimalPicker({
    required this.height,
    required this.initialValue,
    required this.doneText,
    required this.minValue,
    required this.maxValue,
    required this.onChange,
    super.key,
  });

  final double height;
  final double initialValue;
  final String doneText;
  final int minValue;
  final int maxValue;
  final void Function(double) onChange;

  @override
  DecimalPickerState createState() => DecimalPickerState();
}

class DecimalPickerState extends State<DecimalPicker> {
  double? _currentValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height + 40,
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
                    widget.onChange(_currentValue ?? widget.initialValue);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    widget.doneText,
                    style: context.bodyStyle.copyWith(color: ColorName.primary),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.height,
            child: DecimalNumberPicker(
              value: _currentValue ?? widget.initialValue,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              haptics: true,
              textStyle: context.bodyStyle,
              selectedTextStyle: context.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.onChange(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
