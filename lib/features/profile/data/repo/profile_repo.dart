import 'package:dartz/dartz.dart';
import '../models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileModel>> getProfile();
}
