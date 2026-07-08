import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/core/widgets/inputs/input_icon.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 2: job title + professional bio.
class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep>
    with AutomaticKeepAliveClientMixin {
  // Keeps the entered text alive while navigating between PageView steps.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            title: 'Personal Information',
            subtitle:
                'Tell us a bit about your professional background to help us tailor your experience.',
          ),
          Gap(32),
          AppTextFormField(
            label: 'Job Title',
            hintText: 'e.g. Senior Flutter Developer',
            textInputAction: TextInputAction.next,
            prefixIcon: InputIcon(path: AppIcons.briefcaseSvg),
          ),
          Gap(24),
          AppTextFormField(
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
