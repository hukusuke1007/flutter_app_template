import 'dart:math';

extension DoubleExtension on double {
  double roundWithDigit(int digit) {
    final digitValue = pow(10, digit);
    return (this * digitValue).roundToDouble() / digitValue;
  }

  double floorWithDigit(int digit) {
    final digitValue = pow(10, digit);
    return (this * digitValue).floorToDouble() / digitValue;
  }
}
