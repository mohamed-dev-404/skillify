import 'package:dartz/dartz.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/profile/data/models/profile_mock.dart';
import 'package:skillify/features/profile/data/models/profile_model.dart';
import 'package:skillify/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiConsumer api;

  const ProfileRepoImpl(this.api);

  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return mock data for UI testing
    return Right(ProfileMock.mockProfile);
  }
}
