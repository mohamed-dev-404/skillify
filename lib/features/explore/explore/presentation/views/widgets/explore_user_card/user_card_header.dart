import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/explore_user_model.dart';

class UserCardHeader extends StatelessWidget {
  const UserCardHeader({super.key, required this.data});

  final ExploreUserModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _UserAvatar(data: data),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.bold16,
              ),
              const Gap(4),
              Text(
                data.jobTitle?.trim().isNotEmpty == true
                    ? data.jobTitle!
                    : 'No job title added',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.medium12.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.data});

  final ExploreUserModel data;

  @override
  Widget build(BuildContext context) {
    final initial = data.fullName.trim().isEmpty
        ? '?'
        : data.fullName.trim().substring(0, 1).toUpperCase();

    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.secondaryLightActive,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: data.profilePictureUrl == null
            ? _AvatarFallback(initial: initial)
            : Image.network(
                data.profilePictureUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _AvatarFallback(initial: initial),
              ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryLight,
      child: Center(
        child: Text(
          initial,
          style: AppStyles.bold20.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
