import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessMessage(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 2),
  Color backgroundColor = const Color(0xFF303030),
}) async {
  return Flushbar<void>(
    message: message,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    borderRadius: BorderRadius.circular(8),
    duration: duration,
    backgroundColor: backgroundColor,
  ).show(context);
}

Future<void> showErrorMessage(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 2),
  Color backgroundColor = Colors.redAccent,
}) async {
  return Flushbar<void>(
    message: message,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    borderRadius: BorderRadius.circular(8),
    duration: duration,
    backgroundColor: backgroundColor,
  ).show(context);
}
