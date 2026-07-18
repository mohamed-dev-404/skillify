import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/wallet/presentation/view_model/wallet_cubit/wallet_cubit.dart';
import 'package:skillify/features/wallet/presentation/views/widgets/balance_card.dart';
import 'package:skillify/features/wallet/presentation/views/widgets/transaction_item.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WalletHeader(),
            Expanded(
              child: BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  return switch (state.status) {
                    WalletStatus.loading ||
                    WalletStatus.initial => const AnimatedLoadingWidget(
                      height: 110,
                    ),
                    WalletStatus.failure => _WalletFailure(
                      message: state.errorMessage,
                      onRetry: context.read<WalletCubit>().fetchWalletData,
                    ),
                    WalletStatus.success => _WalletContent(state: state),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletHeader extends StatelessWidget {
  const _WalletHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wallet', style: AppStyles.bold28),
                const Gap(3),
                Text(
                  'Track your credits & activity',
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletContent extends StatelessWidget {
  const _WalletContent({required this.state});

  final WalletState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BalanceCard(balance: state.wallet?.currentBalance ?? 0),
          const SizedBox(height: 28),
          Row(
            children: [
              Text('Recent Transactions', style: AppStyles.bold20),
              const Spacer(),
              if (state.transactions.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${state.transactions.length}',
                    style: AppStyles.medium12.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: state.transactions.isEmpty
                ? const EmptyStateWidget(
                    title: 'No transactions yet',
                    subtitle: 'Your wallet transactions will appear here.',
                    lottieHeight: 170,
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 32),
                  )
                : ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: index == state.transactions.length - 1 ? 0 : 12,
                      ),
                      child: TransactionItem(
                        transaction: state.transactions[index],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _WalletFailure extends StatelessWidget {
  const _WalletFailure({required this.message, required this.onRetry});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.errorNormal,
              size: 42,
            ),
            const Gap(12),
            Text(
              message ?? 'Could not load wallet data',
              textAlign: TextAlign.center,
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondaryNormal,
              ),
            ),
            const Gap(14),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
