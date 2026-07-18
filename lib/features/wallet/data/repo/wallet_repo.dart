// wallet repo
import 'package:dartz/dartz.dart';
import 'package:skillify/features/wallet/data/models/wallet_model/wallet_model.dart';

abstract class WalletRepo {
  Future<Either<String, WalletModel>> getWalletHistory();
}