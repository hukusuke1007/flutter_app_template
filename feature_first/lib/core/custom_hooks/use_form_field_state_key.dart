import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<FormFieldState<String>> useFormFieldStateKey({String? debugLabel}) {
  return useState(GlobalKey<FormFieldState<String>>(debugLabel: debugLabel))
      .value;
}
