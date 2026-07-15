import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class UserCardSkills extends StatelessWidget {
  const UserCardSkills({
    super.key,
    this.offeredSkill,
    required this.neededSkills,
  });

  final String? offeredSkill;
  final List<String> neededSkills;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _OfferedSkillRow(skill: offeredSkill),
        const Gap(9),
        _NeededSkillsRow(skills: neededSkills),
      ],
    );
  }
}

class _OfferedSkillRow extends StatelessWidget {
  const _OfferedSkillRow({required this.skill});

  final String? skill;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _SkillLabel(text: 'Teaches'),
        Expanded(
          child: Text(
            skill?.trim().isNotEmpty == true ? skill! : 'Not specified yet',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.bold12.copyWith(
              color: AppColors.secondaryDark,
            ),
          ),
        ),
      ],
    );
  }
}

class _NeededSkillsRow extends StatelessWidget {
  const _NeededSkillsRow({required this.skills});

  static const int _maxVisibleSkills = 3;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    final visibleSkills = skills.take(_maxVisibleSkills).toList();
    final remainingSkills = skills.length - visibleSkills.length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SkillLabel(text: 'Learning', topPadding: 6),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...visibleSkills.map((skill) => _SkillChip(text: skill)),
              if (remainingSkills > 0) _SkillChip(text: '+$remainingSkills'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillLabel extends StatelessWidget {
  const _SkillLabel({required this.text, this.topPadding = 0});

  final String text;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Text(
          text,
          style: AppStyles.medium12.copyWith(
            color: AppColors.textSecondaryNormal,
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 145),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.medium12.copyWith(color: AppColors.primary),
      ),
    );
  }
}
