import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/explore/data/models/explore_user_model.dart';
import 'package:skillify/features/explore/explore/presentation/views/widgets/explore_user_card/user_card_header.dart';
import 'package:skillify/features/explore/explore/presentation/views/widgets/explore_user_card/user_card_profile_button.dart';
import 'package:skillify/features/explore/explore/presentation/views/widgets/explore_user_card/user_card_skills.dart';

class ExploreUserCard extends StatelessWidget {
  const ExploreUserCard({super.key, required this.data, this.onTap});

  final ExploreUserModel data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: .07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Column(
              children: [
                UserCardHeader(data: data),
                const Gap(12),
                const Divider(height: 1),
                const Gap(11),
                UserCardSkills(
                  offeredSkill: data.offeredMainSkill?.name,
                  neededSkills: data.neededMainSkills
                      .map((skill) => skill.name)
                      .toList(),
                ),
                const Gap(12),
                UserCardProfileButton(onPressed: onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
