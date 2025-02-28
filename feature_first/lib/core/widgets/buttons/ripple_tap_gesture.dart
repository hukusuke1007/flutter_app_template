import 'package:flutter/material.dart';

/// Material と InkWell を組み合わせたカスタムタップ可能なウィジェット。
///
/// このウィジェットは以下の場合にのみ使用してください：
/// 1. 標準の Material Design ボタン（FilledButton, TextButton, OutlinedButton など）では
///    実現できない特殊なタップ効果が必要な場合
/// 2. カスタムの形状やレイアウトを持つタップ可能な領域が必要な場合
/// 3. 長押し（onLongPress）のサポートが必要な場合
///
/// 可能な限り、標準の Material Design ボタンを使用することを推奨します。
class RippleTapGesture extends StatelessWidget {
  const RippleTapGesture({
    super.key,
    this.type = MaterialType.transparency,
    this.color = Colors.white,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.child,
  });

  final MaterialType type;
  final Color color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: type,
      borderRadius: borderRadius,
      color: color,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
