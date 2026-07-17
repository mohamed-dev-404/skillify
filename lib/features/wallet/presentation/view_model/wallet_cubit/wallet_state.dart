part of 'wallet_cubit.dart';

enum WalletStatus { initial, loading, success, failure }

class WalletState {
  const WalletState({
    this.status = WalletStatus.initial,
    this.wallet,
    this.transactions = const [],
    this.errorMessage,
  });

  final WalletStatus status;
  final WalletModel? wallet;
  final List<WalletTransactionItemData> transactions;
  final String? errorMessage;

  WalletState copyWith({
    WalletStatus? status,
    WalletModel? wallet,
    List<WalletTransactionItemData>? transactions,
    Object? errorMessage = _unset,
  }) {
    return WalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

class WalletTransactionItemData {
  const WalletTransactionItemData({
    required this.title,
    required this.date,
    required this.amount,
    required this.isPositive,
  });

  final String title;
  final String date;
  final String amount;
  final bool isPositive;
}

const Object _unset = Object();
