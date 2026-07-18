import 'package:dartz/dartz.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/cache/shred_pref/shared_pref_service.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/profile/data/models/profile_model.dart';
import 'package:skillify/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiConsumer api;

  const ProfileRepoImpl(this.api);

  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      final data = await api.get(EndPoints.getProfile);
      final profile = ProfileModel.fromJson(data as Map<String, dynamic>);
      await SharedPrefService.saveFullName(profile.fullName);
      return Right(profile);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }
}
