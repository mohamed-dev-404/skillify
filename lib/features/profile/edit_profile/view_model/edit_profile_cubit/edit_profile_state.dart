part of 'edit_profile_cubit.dart';

sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class EditProfileLoading extends EditProfileState {}
final class EditProfileSuccess extends EditProfileState {}
final class EditProfileFailure extends EditProfileState {
  final String message;
  EditProfileFailure(this.message);
}

final class EditProfilePicturePicked extends EditProfileState {
  final File file;
  EditProfilePicturePicked(this.file);
}
