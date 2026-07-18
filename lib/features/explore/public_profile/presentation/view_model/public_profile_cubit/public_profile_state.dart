part of 'public_profile_cubit.dart';

enum PublicProfileStatus { initial, loading, success, failure }

@immutable
class PublicProfileState {
  const PublicProfileState({
    this.status = PublicProfileStatus.initial,
    this.userId,
    this.profile,
    this.errorMessage,
  });

  final PublicProfileStatus status;
  final int? userId;
  final PublicProfileModel? profile;
  final String? errorMessage;

  PublicProfileState copyWith({
    PublicProfileStatus? status,
    int? userId,
    PublicProfileModel? profile,
    Object? errorMessage = _unset,
  }) {
    return PublicProfileState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      profile: profile ?? this.profile,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

const Object _unset = Object();
