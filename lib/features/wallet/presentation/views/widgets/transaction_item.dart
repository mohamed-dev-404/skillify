import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/wallet/presentation/view_model/wallet_cubit/wallet_cubit.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final WalletTransactionItemData transaction;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isPositive
        ? AppColors.successNormal
        : AppColors.errorNormal;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CustomSvgPicture(
                path: AppIcons.checkCircleSvg,
                color: AppColors.secondaryDark,
                width: 22,
                height: 22,
              ),
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
          Text(
            transaction.amount,
            style: AppStyles.bold14.copyWith(color: amountColor),
          ),
        ],
      ),
    );
  }
}
