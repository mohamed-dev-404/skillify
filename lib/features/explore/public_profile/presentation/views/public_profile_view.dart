import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/offer_session/presentation/views/offer_session_button.dart';
import 'package:skillify/features/explore/public_profile/presentation/view_model/public_profile_cubit/public_profile_cubit.dart';
import 'package:skillify/features/explore/public_profile/presentation/views/widgets/public_profile_header_card.dart';
import 'package:skillify/features/explore/public_profile/presentation/views/widgets/public_profile_sections.dart';
import 'package:skillify/features/explore/request_session/presentation/views/request_session_button.dart';

class PublicProfileView extends StatelessWidget {
  const PublicProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Public Profile',
          style: AppStyles.bold16.copyWith(
            color: AppColors.textPrimaryNormal,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<PublicProfileCubit, PublicProfileState>(
          builder: (context, state) {
            return switch (state.status) {
              PublicProfileStatus.initial ||
              PublicProfileStatus.loading => const Center(
                child: AnimatedLoadingWidget(height: 120),
              ),
              PublicProfileStatus.failure => _PublicProfileFailure(
                message: state.errorMessage,
              ),
              PublicProfileStatus.success => _PublicProfileContent(
                profile: state.profile!,
              ),
            };
          },
        ),
      ),
    );
  }
}

class _PublicProfileContent extends StatelessWidget {
  const _PublicProfileContent({required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PublicProfileHeaderCard(profile: profile),
          const Gap(14),
          // open bottom sheet, and this will called from request||offer session views&viewModel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Expanded(child: RequestSessionButton(profile: profile)),
              Expanded(child: OfferSessionButton(profile: profile)),
            ],
          ),
          const Gap(20),
          PublicProfileSkillSection(
            title: 'Can Teach',
            skill: profile.offeredSkill,
            icon: Icons.school_outlined,
            themeColor: AppColors.secondary,
          ),
          const Gap(20),
          ..._neededSkillCards(profile),

          const Gap(20),
          PublicProfileLanguagesSection(languages: profile.languages),
          const Gap(20),

          PublicProfileBadgesSection(badges: profile.badges),
          const Gap(20),
          PublicProfileReviewsSection(
            reviews: profile.receivedReviews,
            overallRatingScore: profile.overallRatingScore,
          ),
          const Gap(60),
        ],
      ),
    );

    return RefreshIndicator(
      onRefresh: context.read<PublicProfileCubit>().refresh,
      color: AppColors.secondary,
      backgroundColor: AppColors.backgroundNormal,
      child: content,
    );
  }

  List<Widget> _neededSkillCards(PublicProfileModel profile) {
    final neededSkills = profile.neededSkills;

    if (neededSkills.isEmpty) {
      return const [
        PublicProfileSkillSection(
          title: 'Wants to Learn',
          icon: Icons.psychology_outlined,
          themeColor: AppColors.accent,
        ),
        Gap(20),
      ];
    }

    return neededSkills.map((neededSkill) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: PublicProfileSkillSection(
          title: 'Wants to Learn',
          skill: neededSkill,
          icon: Icons.psychology_outlined,
          themeColor: AppColors.accent,
        ),
      );
    }).toList();
  }
}

class _PublicProfileFailure extends StatelessWidget {
  const _PublicProfileFailure({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.errorNormal,
            size: 56,
          ),
          const Gap(16),
          Text(
            'Failed to load profile',
            style: AppStyles.bold16.copyWith(
              color: AppColors.textPrimaryNormal,
            ),
          ),
          const Gap(8),
          Text(
            message ?? 'Something went wrong. Please try again',
            textAlign: TextAlign.center,
            style: AppStyles.regular14.copyWith(
              color: AppColors.textSecondaryNormal,
            ),
          ),
          const Gap(24),
          MainButton(
            text: 'Try Again',
            onPressed: context.read<PublicProfileCubit>().refresh,
          ),
        ],
      ),
    );
  }
}
