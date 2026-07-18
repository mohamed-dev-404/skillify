import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance});

  final int balance;

  @override
  Widget build(BuildContext context) {
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
              top: -42,
              right: -28,
              child: _GlowCircle(
                size: 150,
                color: AppColors.secondary.withValues(alpha: .20),
              ),
            ),
            Positioned(
              bottom: -55,
              left: -22,
              child: _GlowCircle(
                size: 160,
                color: AppColors.accent.withValues(alpha: .14),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .16),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        'Available Balance',
                        style: AppStyles.medium14.copyWith(
                          color: Colors.white.withValues(alpha: .85),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.secondaryLight.withValues(alpha: .9),
                        size: 20,
                      ),
                    ],
                  ),
                  const Gap(24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$balance',
                        style: AppStyles.bold32.copyWith(
                          color: Colors.white,
                          fontSize: 40,
                          height: 1,
                        ),
                      ),
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Credits',
                          style: AppStyles.medium16.copyWith(
                            color: Colors.white.withValues(alpha: .8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      const Gap(6),
                      Text(
                        'Skillify Wallet',
                        style: AppStyles.medium12.copyWith(
                          color: Colors.white.withValues(alpha: .8),
                          letterSpacing: .3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
