import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/core/utils/assets/app_lotties.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
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

  void _onContinue() {
    if (_isLastStepBeforeWelcome) {
      // Last data step: send everything to the API.
      context.read<CompleteProfileCubit>().submit();
    } else {
      _goToStep(_currentStep + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSubmitSuccess) {
          _goToStep(_totalSteps - 1); // welcome step
        } else if (state is CompleteProfileSubmitFailure) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        //? Lookups phases (languages + skills must load before the flow)
        if (state is CompleteProfileInitial ||
            state is CompleteProfileLookupsLoading) {
          return Center(
            child: Lottie.asset(AppLotties.loadingJson, height: 100),
          );
        }
        if (state is CompleteProfileLookupsFailure) {
          return _LookupsError(message: state.message);
        }

        //? Main flow
        return Column(
          children: [
            StepProgressHeader(
              currentStep: _currentStep,
              totalSteps: _totalSteps,
            ),
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
                onContinue: _onContinue,
                continueText: _isLastStepBeforeWelcome
                    ? 'Complete Profile'
                    : 'Continue',
                isLastStep: _isLastStepBeforeWelcome,
                isLoading: state is CompleteProfileSubmitLoading,
              ),
            ],
          ],
        );
      },
    );
  }
}

/// Shown when loading the languages/skills lookups fails.
class _LookupsError extends StatelessWidget {
  const _LookupsError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppStyles.regular16.copyWith(
              color: AppColors.textSecondaryNormal,
            ),
          ),
          const Gap(24),
          MainButton(
            text: 'Try Again',
            minWidth: 160,
            onPressed: () => context.read<CompleteProfileCubit>().loadLookups(),
          ),
        ],
      ),
    );
  }
}
