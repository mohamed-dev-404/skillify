import 'package:flutter/material.dart';
import 'duration_selector.dart';
import 'session_cost.dart';

class RequestSessionDurationSection extends StatelessWidget {
  const RequestSessionDurationSection({
    super.key,
    required this.selectedMinutes,
    required this.onChanged,
    required this.cost,
  });

  final int selectedMinutes;
  final ValueChanged<int> onChanged;
  final int cost;

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      initialValue: selectedMinutes,
      validator: (_) {
        return (selectedMinutes <= 0) ? 'Please select a duration' : null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DurationSelector(
              selectedMinutes: selectedMinutes,
              onChanged: onChanged,
            ),
            const SizedBox(height: 14),
            SessionCost(cost: cost),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
