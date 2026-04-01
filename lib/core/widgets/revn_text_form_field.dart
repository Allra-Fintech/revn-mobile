import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RevnTextFormField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RevnTextFormField({
    Key? key,
    this.controller,
    this.autovalidateMode,
    this.keyboardType,
    this.enabled,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.labelText,
    this.hintText,
    this.helperText,
    this.suffixIcon,
  }) : _fieldKey = key;

  // Forward the provided key to the underlying TextFormField so callers can
  // access the inner FormFieldState when needed.
  final Key? _fieldKey;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      controller: controller,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      enabled: enabled,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
