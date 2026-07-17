import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/profile/data/models/profile_model.dart';
import 'package:skillify/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await profileRepo.getProfile();
    result.fold(
      (errorMessage) => emit(ProfileFailure(errorMessage)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }
}
