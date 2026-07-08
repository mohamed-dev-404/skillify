part of 'complete_profile_cubit.dart';

@immutable
sealed class CompleteProfileState {}

final class CompleteProfileInitial extends CompleteProfileState {}

//? Lookups (languages + skills) loading phases
final class CompleteProfileLookupsLoading extends CompleteProfileState {}

final class CompleteProfileLookupsLoaded extends CompleteProfileState {}

final class CompleteProfileLookupsFailure extends CompleteProfileState {
  final String message;
  CompleteProfileLookupsFailure(this.message);
}

//? Emitted after any selection change so the UI rebuilds
final class CompleteProfileSelectionUpdated extends CompleteProfileState {}

//? Submit phases
final class CompleteProfileSubmitLoading extends CompleteProfileState {}

final class CompleteProfileSubmitSuccess extends CompleteProfileState {}

final class CompleteProfileSubmitFailure extends CompleteProfileState {
  final String message;
  CompleteProfileSubmitFailure(this.message);
}
