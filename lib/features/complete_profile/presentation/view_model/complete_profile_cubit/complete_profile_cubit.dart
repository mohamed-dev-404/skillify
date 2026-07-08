import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/complete_profile/data/models/complete_profile_request_model.dart';
import 'package:skillify/features/complete_profile/data/models/language_model.dart';
import 'package:skillify/features/complete_profile/data/models/main_skill_model.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final CompleteProfileRepo completeProfileRepo;

  CompleteProfileCubit({required this.completeProfileRepo})
    : super(CompleteProfileInitial());

  //! ===============================
  //! Lookups (from API)
  //! ===============================
  List<LanguageModel> languages = [];
  List<MainSkillModel> mainSkills = [];

  Future<void> loadLookups() async {
    emit(CompleteProfileLookupsLoading());

    final languagesResult = await completeProfileRepo.getLanguages();
    final skillsResult = await completeProfileRepo.getMainSkillsWithSubSkills();

    languagesResult.fold(
      (errorMessage) => emit(CompleteProfileLookupsFailure(errorMessage)),
      (languagesData) {
        skillsResult.fold(
          (errorMessage) => emit(CompleteProfileLookupsFailure(errorMessage)),
          (skillsData) {
            languages = languagesData;
            mainSkills = skillsData;
            emit(CompleteProfileLookupsLoaded());
          },
        );
      },
    );
  }

  //! ===============================
  //! User selections
  //! ===============================
  File? photo;
  final jobTitleController = TextEditingController();
  final bioController = TextEditingController();
  final offeredDescriptionController = TextEditingController();
  final Set<int> selectedLanguageIds = {};
  int? offeredMainSkillId;
  final Set<int> offeredSubSkillIds = {};
  final Set<int> neededMainSkillIds = {};
  final Map<int, Set<int>> neededSubSkillIds = {};

  //* The selected offered main skill (with its sub skills)
  MainSkillModel? get offeredMainSkill {
    if (offeredMainSkillId == null) return null;
    for (final skill in mainSkills) {
      if (skill.id == offeredMainSkillId) return skill;
    }
    return null;
  }

  //* The selected needed main skills (with their sub skills)
  List<MainSkillModel> get neededMainSkills => [
    for (final skill in mainSkills)
      if (neededMainSkillIds.contains(skill.id)) skill,
  ];

  void setPhoto(File? newPhoto) {
    photo = newPhoto;
    emit(CompleteProfileSelectionUpdated());
  }

  void toggleLanguage(int id) {
    if (!selectedLanguageIds.remove(id)) selectedLanguageIds.add(id);
    emit(CompleteProfileSelectionUpdated());
  }

  void selectOfferedMainSkill(int id) {
    if (offeredMainSkillId == id) return;
    offeredMainSkillId = id;
    offeredSubSkillIds.clear(); // sub skills belong to the previous selection
    emit(CompleteProfileSelectionUpdated());
  }

  void toggleOfferedSubSkill(int id) {
    if (!offeredSubSkillIds.remove(id)) offeredSubSkillIds.add(id);
    emit(CompleteProfileSelectionUpdated());
  }

  void toggleNeededMainSkill(int id) {
    if (!neededMainSkillIds.remove(id)) {
      neededMainSkillIds.add(id);
    } else {
      neededSubSkillIds.remove(id); // clear its sub skills when deselected
    }
    emit(CompleteProfileSelectionUpdated());
  }

  void toggleNeededSubSkill(int mainSkillId, int subSkillId) {
    final selected = neededSubSkillIds.putIfAbsent(mainSkillId, () => {});
    if (!selected.remove(subSkillId)) selected.add(subSkillId);
    emit(CompleteProfileSelectionUpdated());
  }

  //! ===============================
  //! Submit
  //! ===============================
  Future<void> submit() async {
    if (offeredMainSkillId == null) {
      emit(CompleteProfileSubmitFailure('Please select a skill you can teach'));
      return;
    }

    emit(CompleteProfileSubmitLoading());

    final request = CompleteProfileRequestModel(
      profilePicture: photo,
      bio: bioController.text.trim(),
      jobTitle: jobTitleController.text.trim(),
      offeredMainSkillId: offeredMainSkillId!,
      offeredSubSkillIds: offeredSubSkillIds.toList(),
      offeredDescription: offeredDescriptionController.text.trim(),
      neededSkills: [
        for (final mainId in neededMainSkillIds)
          NeededSkillSelection(
            mainSkillId: mainId,
            subSkillIds: neededSubSkillIds[mainId]?.toList() ?? const [],
          ),
      ],
      languageIds: selectedLanguageIds.toList(),
    );

    final result = await completeProfileRepo.completeProfile(request);
    result.fold(
      (errorMessage) => emit(CompleteProfileSubmitFailure(errorMessage)),
      (_) => emit(CompleteProfileSubmitSuccess()),
    );
  }

  @override
  Future<void> close() {
    jobTitleController.dispose();
    bioController.dispose();
    offeredDescriptionController.dispose();
    return super.close();
  }
}
