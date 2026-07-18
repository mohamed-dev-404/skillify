import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/wallet/presentation/view_model/wallet_cubit/wallet_cubit.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final WalletTransactionItemData transaction;

  @override
  Widget build(BuildContext context) {
    final isPositive = transaction.isPositive;
    final accent = isPositive ? AppColors.successNormal : AppColors.errorNormal;
    final accentBg = isPositive ? AppColors.successLight : AppColors.errorLight;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderNormal),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accentBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isPositive
                  ? Icons.south_west_rounded
                  : Icons.north_east_rounded,
              color: accent,
              size: 22,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.bold15,
                ),
                const Gap(5),
                Text(
                  transaction.date,
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accentBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              transaction.amount,
              style: AppStyles.bold14.copyWith(color: accent),
            ),
          ),
        ],
      ),
    );
  }
}
