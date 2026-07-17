import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class SessionCost extends StatelessWidget {
  const SessionCost({required this.cost, Key? key}) : super(key: key);

  final int cost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Session Cost',
          style: AppStyles.regular14.copyWith(
            color: AppColors.textSecondaryNormal,
          ),
        ),
        const Spacer(),
        Text(
          cost.toString() + ' Credits',
          style: AppStyles.bold14.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}
