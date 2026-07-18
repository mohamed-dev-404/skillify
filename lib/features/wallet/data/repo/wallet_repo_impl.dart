// wallet repo impl
import 'package:dartz/dartz.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/wallet/data/models/wallet_model/wallet_model.dart';
import 'package:skillify/features/wallet/data/repo/wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final ApiConsumer api;

  const WalletRepoImpl(this.api);

  @override
  Future<Either<String, WalletModel>> getWalletHistory() async {
    try {
      final data = await api.get(
        EndPoints.creditTransactionHistory,
      );

      final wallet = WalletModel.fromJson(
        data as Map<String, dynamic>,
      );

      return Right(wallet);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left(
        'Something went wrong. Please try again',
      );
    }
  }
}