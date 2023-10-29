import 'package:flutter/material.dart';

import '../../../../../extensions/context_extension.dart';
import '../../../../../extensions/string_extension.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required this.textFormFieldKey,
    this.padding = EdgeInsets.zero,
    this.focusNode,
    this.title = 'メールアドレス',
    this.hintText,
    this.initialValue,
    this.counterText,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.maxLength,
    super.key,
  });

  final GlobalKey<FormFieldState<String>> textFormFieldKey;
  final EdgeInsets padding;
  final FocusNode? focusNode;
  final String title;
  final String? hintText;
  final String? initialValue;
  final String? counterText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(title, style: context.bodyStyle),
          ),
          TextFormField(
            style: context.bodyStyle,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: const OutlineInputBorder(),
              isDense: true,
              counterText: counterText,
              suffixIcon: SuffixIcon(
                onTap: () {
                  textFormFieldKey.currentState?.didChange('');
                },
              ),
            ),
            key: textFormFieldKey,
            initialValue: initialValue,
            validator: validator ??
                (value) => (value == null || !value.trim().isEmail)
                    ? '正しいメールアドレスを入力してください'
                    : null,
            keyboardType: TextInputType.emailAddress,
            textInputAction: textInputAction ?? TextInputAction.done,
            onFieldSubmitted: onFieldSubmitted,
            autocorrect: false,
            autofillHints: const [
              AutofillHints.username,
              AutofillHints.email,
            ],
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 4,
      onPressed: onTap,
      icon: const Icon(Icons.clear),
    );
  }
}
