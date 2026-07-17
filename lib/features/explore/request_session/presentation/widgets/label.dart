import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class Label extends StatelessWidget {
  const Label(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.bold16.copyWith(color: AppColors.textPrimaryNormal),
    );
  }
}
