import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/explore_model.dart';

class UserCardHeader extends StatelessWidget {
  const UserCardHeader({super.key, required this.data});

  final ExploreUserCardData data;

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
                data.jobTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.medium12.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        _RatingBadge(rating: data.rating),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.data});

  final ExploreUserCardData data;

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
        child: data.imageUrl == null
            ? _AvatarFallback(initial: initial)
            : Image.network(
                data.imageUrl!,
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

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            size: 15,
            color: AppColors.warningNormal,
          ),
          const Gap(3),
          Text(
            rating?.toStringAsFixed(1) ?? 'New',
            style: AppStyles.bold12,
          ),
        ],
      ),
    );
  }
}
