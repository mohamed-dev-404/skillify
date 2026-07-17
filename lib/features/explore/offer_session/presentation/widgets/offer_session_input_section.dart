import 'package:flutter/material.dart';
import 'package:skillify/features/explore/request_session/presentation/widgets/input_field.dart';
import 'package:skillify/features/explore/request_session/presentation/widgets/label.dart';

class OfferSessionInputSection extends StatelessWidget {
  const OfferSessionInputSection({
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
