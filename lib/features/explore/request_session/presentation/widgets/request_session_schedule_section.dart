import 'package:flutter/material.dart';
import 'package:skillify/core/functions/time_of_day.dart';
import 'schedule_picker.dart';

class RequestSessionScheduleSection extends StatelessWidget {
  const RequestSessionScheduleSection({
    super.key,
    required this.date,
    required this.time,
    required this.onDatePicked,
    required this.onTimePicked,
  });

  final DateTime? date;
  final TimeOfDayValue? time;
  final ValueChanged<DateTime> onDatePicked;
  final ValueChanged<TimeOfDayValue> onTimePicked;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: date != null && time != null,
      validator: (_) {
        return (date == null || time == null)
            ? 'Please pick a date and time'
            : null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SchedulePicker(
              date: date,
              time: time,
              onDatePicked: onDatePicked,
              onTimePicked: onTimePicked,
            ),
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
