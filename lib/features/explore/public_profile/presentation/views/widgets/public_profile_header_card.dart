import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';

class PublicProfileHeaderCard extends StatelessWidget {
  const PublicProfileHeaderCard({
    super.key,
    required this.profile,
  });

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final hasBio = profile.bio != null && profile.bio!.trim().isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: .28),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Gradient base
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryDark,
                      AppColors.primary,
                      AppColors.primaryHover,
                    ],
                  ),
                ),
              ),
            ),

            // Decorative brand glow circles
            Positioned(
              top: -46,
              right: -30,
              child: _GlowCircle(
                size: 150,
                color: AppColors.secondary.withValues(alpha: .20),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -26,
              child: _GlowCircle(
                size: 170,
                color: AppColors.accent.withValues(alpha: .14),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _ProfileAvatar(imageUrl: profile.profilePictureUrl),
                      const Gap(16),
                      Expanded(
                        child: _ProfileIdentity(profile: profile),
                      ),
                    ],
                  ),
                  if (hasBio) ...[
                    const Gap(16),
                    Text(
                      profile.bio!.trim(),
                      style: AppStyles.regular14.copyWith(
                        color: Colors.white.withValues(alpha: .85),
                        height: 1.45,
                      ),
                    ),
                  ],
                  const Gap(20),
                  _PublicProfileStats(profile: profile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarker.withValues(alpha: .3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primaryLight,
              child: const Icon(
                LineIcons.user,
                size: 38,
                color: AppColors.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity({required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profile.fullName ?? 'No Name',
          style: AppStyles.bold20.copyWith(color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .14),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            profile.jobTitle ?? 'Skillify Member',
            style: AppStyles.medium12.copyWith(
              color: AppColors.secondaryLight,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _PublicProfileStats extends StatelessWidget {
  const _PublicProfileStats({required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatChip(
            icon: LineIcons.star,
            label: 'Rating',
            value: _ratingText(profile.overallRatingScore),
          ),
        ),
        const Gap(12),
        Expanded(
          child: _StatChip(
            icon: LineIcons.history,
            label: 'Sessions',
            value: '${profile.completedSessions ?? 0} Done',
          ),
        ),
      ],
    );
  }

  String _ratingText(num? rating) {
    if (rating == null) return 'New';
    return rating.toStringAsFixed(1);
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: .18)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 19),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.regular12.copyWith(
                    color: Colors.white.withValues(alpha: .75),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: AppStyles.bold14.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
