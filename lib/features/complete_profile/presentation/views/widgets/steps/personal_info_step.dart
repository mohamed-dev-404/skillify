import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/core/widgets/inputs/input_icon.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 2: job title + professional bio.
class PersonalInfoStep extends StatelessWidget {
  const PersonalInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers live in the cubit so the text survives step navigation
    // and is available on submit.
    final cubit = context.read<CompleteProfileCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepTitle(
            title: 'Personal Information',
            subtitle:
                'Tell us a bit about your professional background to help us tailor your experience.',
          ),
          const Gap(32),
          AppTextFormField(
            controller: cubit.jobTitleController,
            label: 'Job Title',
            hintText: 'e.g. Senior Flutter Developer',
            textInputAction: TextInputAction.next,
            prefixIcon: const InputIcon(path: AppIcons.briefcaseSvg),
          ),
          const Gap(24),
          AppTextFormField(
            controller: cubit.bioController,
            label: 'Professional Bio',
            hintText:
                'Flutter Developer with 4 years of experience building cross-platform mobile applications...',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
