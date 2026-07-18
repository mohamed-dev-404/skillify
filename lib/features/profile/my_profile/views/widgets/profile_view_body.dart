import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/explore/explore/presentation/views/widgets/explore_header.dart';
import 'package:skillify/features/profile/my_profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:skillify/features/profile/my_profile/views/widgets/profile_badges_section.dart';
import 'package:skillify/features/profile/my_profile/views/widgets/profile_header_card.dart';
import 'package:skillify/features/profile/my_profile/views/widgets/profile_languages_section.dart';
import 'package:skillify/features/profile/my_profile/views/widgets/profile_reviews_section.dart';
import 'package:skillify/features/profile/my_profile/views/widgets/profile_skill_card.dart';
import 'package:skillify/features/settings/presentation/views/settings_view.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return const Center(
            child: AnimatedLoadingWidget(height: 120),
          );
        }

        if (state is ProfileFailure) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.errorNormal,
                  size: 64,
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
                  state.message,
                  textAlign: TextAlign.center,
                  style: AppStyles.regular14.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
                const Gap(24),
                MainButton(
                  text: 'Try Again',
                  onPressed: () => context.read<ProfileCubit>().getProfile(),
                ),
              ],
            ),
          );
        }

        if (state is ProfileSuccess) {
          final profile = state.profile;

          return RefreshIndicator(
            onRefresh: () => context.read<ProfileCubit>().getProfile(),
            color: AppColors.secondary,
            backgroundColor: AppColors.backgroundNormal,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Screen Title & Edit Button ───
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Profile',
                        style: AppStyles.bold24.copyWith(
                          color: AppColors.textPrimaryNormal,
                        ),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          HeaderActionButton(
                            icon: Icons.edit,
                            iconColor: AppColors.secondary,
                            onTap: () async {
                              final result = await context.push(
                                Routes.editProfile,
                                extra: profile,
                              );
                              if (context.mounted) {
                                if (result == true) {
                                  AppSnackBar.success(
                                    context,
                                    'Profile updated successfully!',
                                  );
                                }
                                context.read<ProfileCubit>().getProfile();
                              }
                            },
                          ),
                          HeaderActionButton(
                            icon: Icons.settings_rounded,
                            iconColor: AppColors.secondary,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SettingsView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),

                  // ─── Header ───
                  ProfileHeaderCard(profile: profile),
                  const Gap(20),

                  // ─── Languages ───
                  ProfileLanguagesSection(languages: profile.languages),
                  const Gap(20),

                  // ─── Offered Skill ───
                  ProfileSkillCard(
                    title: 'Skills I Offer',
                    mainSkillName: profile.offeredSkill?.mainSkill?.name,
                    subSkills: profile.offeredSkill?.subSkills
                        ?.map((e) => e.name ?? '')
                        .toList(),
                    description: profile.offeredSkill?.description,
                    sectionIcon: Icons.school_outlined,
                    themeColor: AppColors.secondary,
                  ),
                  const Gap(20),

                  // ─── Needed Skills ───
                  if (profile.neededSkills == null ||
                      profile.neededSkills!.isEmpty) ...[
                    const ProfileSkillCard(
                      title: 'Skills I Want to Learn',
                      sectionIcon: Icons.psychology_outlined,
                      themeColor: AppColors.accent,
                    ),
                    const Gap(20),
                  ] else ...[
                    ...profile.neededSkills!.map((neededSkill) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ProfileSkillCard(
                          title: 'Skills I Want to Learn',
                          mainSkillName:
                              neededSkill.mainSkill?.name ?? 'Unknown',
                          subSkills:
                              neededSkill.subSkills
                                  ?.map((e) => e.name ?? '')
                                  .toList() ??
                              [],
                          description: neededSkill.description ?? '',
                          sectionIcon: Icons.psychology_outlined,
                          themeColor: AppColors.accent,
                        ),
                      );
                    }),
                  ],

                  // ─── Badges ───
                  ProfileBadgesSection(badges: profile.badges),
                  const Gap(20),

                  // ─── Reviews ───
                  ProfileReviewsSection(
                    reviews: profile.receivedReviews,
                    overallRatingScore: profile.overallRatingScore,
                  ),
                  const Gap(20),

                  // Bottom safe area
                  const Gap(60),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
