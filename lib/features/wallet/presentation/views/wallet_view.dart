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
      appBar: AppBar(
        title: Row(
          children: [
             Text('Wallet',style: AppStyles.bold28),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppStyles.bold24.copyWith(
          color: AppColors.textPrimaryNormal,
        ),
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          return switch (state.status) {
            WalletStatus.loading ||
            WalletStatus.initial => const AnimatedLoadingWidget(height: 110),
            WalletStatus.failure => _WalletFailure(
              message: state.errorMessage,
              onRetry: context.read<WalletCubit>().fetchWalletData,
            ),
            WalletStatus.success => _WalletContent(state: state),
          };
        },
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BalanceCard(balance: state.wallet?.currentBalance ?? 0),
          const SizedBox(height: 28),
          Text('Recent Transactions', style: AppStyles.bold20),
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
