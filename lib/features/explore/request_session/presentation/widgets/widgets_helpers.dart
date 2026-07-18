import 'package:flutter/material.dart';
import 'package:skillify/core/functions/time_of_day.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

InputDecoration inputDecoration({String? hint}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppStyles.regular16.copyWith(
      color: AppColors.textSecondaryNormal,
    ),
    filled: true,
    fillColor: AppColors.backgroundNormal,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.borderNormal),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
  );
}

extension TimeOfDayValueHelpers on TimeOfDayValue {
  int get hourOfPeriod => hour % 12;
  String get periodLabel => hour >= 12 ? 'PM' : 'AM';
}
