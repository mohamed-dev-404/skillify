import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_nav_bar.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_progress_header.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/languages_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/main_skill_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/needed_skills_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/needed_sub_skills_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/personal_info_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/profile_photo_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/sub_skills_step.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/steps/welcome_step.dart';

class CompleteProfileViewBody extends StatefulWidget {
  const CompleteProfileViewBody({super.key});

  @override
  State<CompleteProfileViewBody> createState() =>
      _CompleteProfileViewBodyState();
}

class _CompleteProfileViewBodyState extends State<CompleteProfileViewBody> {
  static const int _totalSteps = 8;

  final _pageController = PageController();
  int _currentStep = 0;

  bool get _isWelcomeStep => _currentStep == _totalSteps - 1;
  bool get _isLastStepBeforeWelcome => _currentStep == _totalSteps - 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepProgressHeader(currentStep: _currentStep, totalSteps: _totalSteps),
        const Gap(24),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              ProfilePhotoStep(),
              PersonalInfoStep(),
              LanguagesStep(),
              MainSkillStep(),
              SubSkillsStep(),
              NeededSkillsStep(),
              NeededSubSkillsStep(),
              WelcomeStep(),
            ],
          ),
        ),
        if (!_isWelcomeStep) ...[
          const Gap(16),
          StepNavBar(
            onBack: _currentStep == 0
                ? null
                : () => _goToStep(_currentStep - 1),
            onContinue: () => _goToStep(_currentStep + 1),
            continueText: _isLastStepBeforeWelcome
                ? 'Complete Profile'
                : 'Continue',
            isLastStep: _isLastStepBeforeWelcome,
          ),
        ],
      ],
    );
  }
}
