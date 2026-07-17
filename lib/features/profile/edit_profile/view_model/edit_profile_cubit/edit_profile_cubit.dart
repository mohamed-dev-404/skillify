import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/complete_profile/data/models/complete_profile_request_model.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';
import 'package:skillify/features/profile/data/models/profile_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final CompleteProfileRepo completeProfileRepo;

  EditProfileCubit({required this.completeProfileRepo}) : super(EditProfileInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  
  File? profileImage;
  ProfileModel? initialProfile;

  void init(ProfileModel profile) {
    initialProfile = profile;
    fullNameController.text = profile.fullName ?? '';
    bioController.text = profile.bio ?? '';
    jobTitleController.text = profile.jobTitle ?? '';
  }

  void pickImage(File file) {
    profileImage = file;
    emit(EditProfilePicturePicked(file));
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    
    emit(EditProfileLoading());

    // 1. Submit Profile Picture if picked
    if (profileImage != null) {
      final imageRes = await completeProfileRepo.updateProfilePicture(profileImage!);
      bool hasError = false;
      imageRes.fold(
        (err) {
          hasError = true;
          emit(EditProfileFailure(err));
        },
        (_) => null,
      );
      if (hasError) return;
    }

    // 2. Submit Profile Data
    if (initialProfile != null) {
      final request = CompleteProfileRequestModel(
        fullName: fullNameController.text,
        bio: bioController.text,
        jobTitle: jobTitleController.text,
        offeredMainSkillId: initialProfile!.offeredSkill?.mainSkill?.id ?? 0,
        offeredSubSkillIds: initialProfile!.offeredSkill?.subSkills?.map((e) => e.id!).toList() ?? [],
        offeredDescription: initialProfile!.offeredSkill?.description,
        neededSkills: initialProfile!.neededSkills?.map((e) => NeededSkillSelection(
          mainSkillId: e.mainSkill?.id ?? 0,
          subSkillIds: e.subSkills?.map((s) => s.id!).toList() ?? [],
        )).toList() ?? [],
        languageIds: initialProfile!.languages?.map((e) => e.id!).toList() ?? [],
      );

      final profileRes = await completeProfileRepo.completeProfile(request);
      profileRes.fold(
        (err) => emit(EditProfileFailure(err)),
        (_) => emit(EditProfileSuccess()),
      );
    } else {
      emit(EditProfileSuccess());
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    bioController.dispose();
    jobTitleController.dispose();
    return super.close();
  }
}
