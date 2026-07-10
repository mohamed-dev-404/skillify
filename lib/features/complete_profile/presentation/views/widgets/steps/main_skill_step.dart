import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/skill_category_card.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 4: single-select the primary skill the user can teach.
class MainSkillStep extends StatelessWidget {
  const MainSkillStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final cubit = context.read<CompleteProfileCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepTitle(
                title: 'What can you teach?',
                subtitle:
                    'Select your primary area of expertise. You can add more specific skills later.',
              ),
              const Gap(32),
              for (final skill in cubit.mainSkills) ...[
                SkillCategoryCard(
                  title: skill.name,
                  isSelected: cubit.offeredMainSkillId == skill.id,
                  onTap: () => cubit.selectOfferedMainSkill(skill.id),
                ),
                const Gap(16),
              ],
            ],
          ),
        );
      },
    );
  }
}
