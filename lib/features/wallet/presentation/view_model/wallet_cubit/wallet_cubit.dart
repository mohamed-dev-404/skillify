import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/wallet/data/models/wallet_model/history.dart';
import 'package:skillify/features/wallet/data/models/wallet_model/wallet_model.dart';
import 'package:skillify/features/wallet/data/repo/wallet_repo.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({required this.walletRepo}) : super(const WalletState());

  final WalletRepo walletRepo;

  Future<void> fetchWalletData() async {
    emit(state.copyWith(status: WalletStatus.loading, errorMessage: null));

    final result = await walletRepo.getWalletHistory();
    if (isClosed) return;

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: WalletStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (wallet) => emit(
        state.copyWith(
          status: WalletStatus.success,
          wallet: wallet,
          transactions: _mapTransactions(wallet.history ?? const []),
          errorMessage: null,
        ),
      ),
    );
  }

  List<WalletTransactionItemData> _mapTransactions(List<History> history) {
    return history.map((transaction) {
      final amount = transaction.amount ?? 0;
      return WalletTransactionItemData(
        title: _transactionTitle(transaction.type),
        date: _formatDate(transaction.createdAt),
        amount: _formatAmount(amount),
        isPositive: amount >= 0,
      );
    }).toList();
  }

  String _transactionTitle(String? type) {
    return switch (type) {
      'EscrowRelease' => 'Session Completed',
      'EscrowHold' => 'Session Booked',
      _ => 'Transaction',
    };
  }

  String _formatAmount(int amount) {
    final prefix = amount > 0 ? '+' : '';
    return '$prefix$amount Credits';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
