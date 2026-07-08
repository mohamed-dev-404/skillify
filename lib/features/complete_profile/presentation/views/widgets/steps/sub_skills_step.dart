import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/selectable_chip.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 5: multi-select the specific sub skills + expertise description.
class SubSkillsStep extends StatelessWidget {
  const SubSkillsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final cubit = context.read<CompleteProfileCubit>();
        final mainSkill = cubit.offeredMainSkill;

        if (mainSkill == null) {
          return const Center(
            child: StepTitle(
              title: 'Select your main skill first',
              subtitle:
                  'Go back one step and choose your primary area of expertise.',
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepTitle(
                title: 'Specify your expertise',
                subtitle:
                    'Select the specific areas where you can offer guidance.',
              ),
              const Gap(32),
              Text(
                mainSkill.name,
                style: AppStyles.bold24.copyWith(color: AppColors.primary),
              ),
              const Gap(16),
              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: [
                  for (final subSkill in mainSkill.subSkills)
                    SelectableChip(
                      label: subSkill.name,
                      isSelected: cubit.offeredSubSkillIds.contains(
                        subSkill.id,
                      ),
                      onTap: () => cubit.toggleOfferedSubSkill(subSkill.id),
                    ),
                ],
              ),
              const Gap(32),
              Text(
                'Description of expertise',
                style: AppStyles.bold16.copyWith(color: AppColors.primary),
              ),
              const Gap(8),
              Text(
                'Please provide a brief description of your experience with the skills you selected above',
                style: AppStyles.regular14.copyWith(
                  color: AppColors.textSecondaryNormal,
                ),
              ),
              const Gap(12),
              AppTextFormField(
                controller: cubit.offeredDescriptionController,
                hintText:
                    'I can teach Clean Architecture, state management with Riverpod, and building custom render objects.',
                maxLines: 4,
              ),
            ],
          ),
        );
      },
    );
  }
}
