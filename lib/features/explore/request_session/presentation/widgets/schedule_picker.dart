import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/functions/time_of_day.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'widgets_helpers.dart';
import 'label.dart';

class SchedulePicker extends StatelessWidget {
  const SchedulePicker({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label('Schedule'),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: PickerBox(
                text: date == null ? 'mm/dd/yyyy' : _dateText(date!),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDate: date ?? DateTime.now(),
                  );

                  if (pickedDate != null) onDatePicked(pickedDate);
                },
              ),
            ),
            const Gap(16),
            Expanded(
              child: PickerBox(
                text: time == null ? '--:-- --' : _timeText(time!),
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    onTimePicked(
                      TimeOfDayValue(
                        hour: pickedTime.hour,
                        minute: pickedTime.minute,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _dateText(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  String _timeText(TimeOfDayValue time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${time.periodLabel}';
  }
}

class PickerBox extends StatelessWidget {
  const PickerBox({required this.text, required this.onTap, super.key});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 56,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.backgroundNormal,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderNormal),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppStyles.regular16.copyWith(
            color: AppColors.textPrimaryNormal,
          ),
        ),
      ),
    );
  }
}
