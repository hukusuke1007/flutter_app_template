import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../extensions/context_extension.dart';
import '../../../../../extensions/string_extension.dart';

class PasswordTextField extends HookWidget {
  const PasswordTextField({
    required this.textFormFieldKey,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.focusNode,
    this.title = 'パスワード',
    this.hintText,
    this.initialValue,
    this.counterText,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.maxLength,
    super.key,
  });

  final String title;
  final GlobalKey<FormFieldState<String>> textFormFieldKey;
  final EdgeInsets padding;
  final FocusNode? focusNode;
  final String? hintText;
  final String? initialValue;
  final String? counterText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final visibleState = useState(false);
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
                isVisible: visibleState.value,
                onTap: (value) {
                  visibleState.value = value;
                },
              ),
            ),
            key: textFormFieldKey,
            initialValue: initialValue,
            obscureText: !visibleState.value,
            validator: validator ??
                (value) => (value == null || !value.trim().isPassword)
                    ? '正しいパスワードを入力してください'
                    : null,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: textInputAction ?? TextInputAction.done,
            onFieldSubmitted: onFieldSubmitted,
            autocorrect: false,
            autofillHints: const [AutofillHints.password],
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({
    required this.isVisible,
    required this.onTap,
    super.key,
  });

  final bool isVisible;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 4,
      onPressed: () {
        onTap(!isVisible);
      },
      icon: isVisible
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
    );
  }
}
