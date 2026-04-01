import 'package:flutter/services.dart';

final _nonDigitRegExp = RegExp(r'\D');

String normalizeBusinessNumber(String value) {
  final digits = value.replaceAll(_nonDigitRegExp, '');
  if (digits.length <= 10) {
    return digits;
  }

  return digits.substring(0, 10);
}

String formatBusinessNumber(String value) {
  final digits = normalizeBusinessNumber(value);
  if (digits.length <= 3) {
    return digits;
  }

  if (digits.length <= 5) {
    return '${digits.substring(0, 3)}-${digits.substring(3)}';
  }

  return '${digits.substring(0, 3)}-${digits.substring(3, 5)}-${digits.substring(5)}';
}

class BusinessNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatBusinessNumber(newValue.text);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
