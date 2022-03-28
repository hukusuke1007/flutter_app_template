import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<FormFieldState<String>> useFormFieldStateKey() {
  return useState(GlobalKey<FormFieldState<String>>()).value;
}
