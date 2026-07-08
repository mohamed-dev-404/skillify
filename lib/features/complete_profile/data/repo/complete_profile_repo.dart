import 'package:dartz/dartz.dart';
import 'package:skillify/features/complete_profile/data/models/complete_profile_request_model.dart';
import 'package:skillify/features/complete_profile/data/models/language_model.dart';
import 'package:skillify/features/complete_profile/data/models/main_skill_model.dart';

/// Contract for the complete profile feature.
/// Left = error message, Right = success data.
abstract class CompleteProfileRepo {
  Future<Either<String, List<LanguageModel>>> getLanguages();

  Future<Either<String, List<MainSkillModel>>> getMainSkillsWithSubSkills();

  Future<Either<String, Unit>> completeProfile(
    CompleteProfileRequestModel request,
  );
}
