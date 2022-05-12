import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../res/typography.dart';

class WrappedAutoSizeText extends StatelessWidget {
  const WrappedAutoSizeText(
    this.text, {
    this.fontSize,
    this.fontWeight,
    required this.minFontSize,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.maxFontSize = double.infinity,
    super.key,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double minFontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double maxFontSize;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: kFontFamily,
        locale: const Locale('ja', 'JP'),
      ),
      overflow: overflow,
      textAlign: textAlign,
      locale: const Locale('ja', 'JP'),
      maxLines: maxLines,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
    );
  }
}
