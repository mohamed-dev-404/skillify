import 'package:flutter/material.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'widgets_helpers.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.hint,
    required this.onChanged,
    this.maxLines = 1,
    this.validator,
    Key? key,
  }) : super(key: key);

  final String hint;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: maxLines,
      style: AppStyles.regular16,
      decoration: inputDecoration(hint: hint),
      validator: validator,
    );
  }
}
