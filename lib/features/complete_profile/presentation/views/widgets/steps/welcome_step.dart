import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:skillify/core/utils/assets/app_lotties.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';

/// Step 8: profile completed successfully.
class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Lottie.asset(
          AppLotties.successJson,
          width: 180,
          height: 180,
          repeat: false,
        ),
        const Gap(40),
        Text(
          'Welcome to Skillify!',
          textAlign: TextAlign.center,
          style: AppStyles.bold28.copyWith(color: AppColors.primary),
        ),
        const Gap(16),
        Text(
          "Your profile is ready. Let's start learning and achieving your goals.",
          textAlign: TextAlign.center,
          style: AppStyles.regular16.copyWith(
            color: AppColors.textSecondaryNormal,
          ),
        ),
        const Spacer(flex: 2),
        MainButton(
          text: 'Explore Skillify',
          bgColor: AppColors.secondary,
          onPressed: () {
            // TODO: navigate to the main view when it is ready
          },
        ),
      ],
    );
  }
}
