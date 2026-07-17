import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/constants/api_keys.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/complete_profile/data/models/complete_profile_request_model.dart';
import 'package:skillify/features/complete_profile/data/models/language_model.dart';
import 'package:skillify/features/complete_profile/data/models/main_skill_model.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';

class CompleteProfileRepoImpl implements CompleteProfileRepo {
  final ApiConsumer api;

  const CompleteProfileRepoImpl(this.api);

  @override
  Future<Either<String, List<LanguageModel>>> getLanguages() async {
    try {
      final data = await api.get(EndPoints.getLanguages);
      final languages = (data as List<dynamic>)
          .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(languages);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, List<MainSkillModel>>>
  getMainSkillsWithSubSkills() async {
    try {
      final data = await api.get(EndPoints.getMainSkillsWithSubSkills);
      final skills = (data as List<dynamic>)
          .map((e) => MainSkillModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(skills);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, Unit>> completeProfile(
    CompleteProfileRequestModel request,
  ) async {
    try {
      await api.put(EndPoints.completeProfile, data: request.toJson());
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, Unit>> updateProfilePicture(File photo) async {
    try {
      await api.put(
        EndPoints.updateProfilePicture,
        data: {
          ApiKeys.profilePicture: await MultipartFile.fromFile(photo.path),
        },
        isFormData: true,
      );
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }
}
