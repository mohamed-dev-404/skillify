import 'package:flutter/material.dart';
import 'input_field.dart';
import 'label.dart';

class RequestSessionInputSection extends StatelessWidget {
  const RequestSessionInputSection({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.maxLines = 1,
    this.validator,
  });

  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(label),
        const SizedBox(height: 8),
        InputField(
          hint: hint,
          maxLines: maxLines,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
