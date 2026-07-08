import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skillify/core/constants/api_keys.dart';

/// One needed skill selection: a main skill + the sub skills under it.
class NeededSkillSelection {
  final int mainSkillId;
  final List<int> subSkillIds;

  const NeededSkillSelection({
    required this.mainSkillId,
    this.subSkillIds = const [],
  });
}

/// Request body for `PUT /Users/me/profile` (multipart/form-data).
class CompleteProfileRequestModel {
  final File? profilePicture;
  final String? bio;
  final String? jobTitle;
  final int offeredMainSkillId;
  final List<int> offeredSubSkillIds;
  final String? offeredDescription;
  final List<NeededSkillSelection> neededSkills;
  final List<int> languageIds;

  const CompleteProfileRequestModel({
    this.profilePicture,
    this.bio,
    this.jobTitle,
    required this.offeredMainSkillId,
    this.offeredSubSkillIds = const [],
    this.offeredDescription,
    this.neededSkills = const [],
    this.languageIds = const [],
  });

  /// Builds the form data with ASP.NET style keys:
  /// repeated keys for int lists and `NeededSkills[i].field` for nested items.
  Future<FormData> toFormData() async {
    final form = FormData();

    void addField(String key, String value) {
      form.fields.add(MapEntry(key, value));
    }

    if (bio?.isNotEmpty == true) addField(ApiKeys.bioForm, bio!);
    if (jobTitle?.isNotEmpty == true) addField(ApiKeys.jobTitleForm, jobTitle!);
    addField(ApiKeys.offeredMainSkillForm, '$offeredMainSkillId');
    for (final id in offeredSubSkillIds) {
      addField(ApiKeys.offeredSubSkillsForm, '$id');
    }
    if (offeredDescription?.isNotEmpty == true) {
      addField(ApiKeys.offeredDescriptionForm, offeredDescription!);
    }
    for (final id in languageIds) {
      addField(ApiKeys.languageIdsForm, '$id');
    }
    for (var i = 0; i < neededSkills.length; i++) {
      final needed = neededSkills[i];
      addField(
        '${ApiKeys.neededSkillsForm}[$i].${ApiKeys.mainSkillIdForm}',
        '${needed.mainSkillId}',
      );
      for (final subId in needed.subSkillIds) {
        addField(
          '${ApiKeys.neededSkillsForm}[$i].${ApiKeys.subSkillIdsForm}',
          '$subId',
        );
      }
    }

    if (profilePicture != null) {
      form.files.add(
        MapEntry(
          ApiKeys.profilePictureForm,
          await MultipartFile.fromFile(profilePicture!.path),
        ),
      );
    }

    return form;
  }
}
