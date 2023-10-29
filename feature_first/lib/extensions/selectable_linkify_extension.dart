import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

extension SelectableLinkifyExtension on SelectableLinkify {
  static Widget defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }
}
