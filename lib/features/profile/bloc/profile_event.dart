// profile_event.dart
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfile extends ProfileEvent {
  final String userId;
  const LoadProfile(this.userId);
  @override
  List<Object?> get props => [userId];
}

class UpdateProfile extends ProfileEvent {
  final AppUser updatedUser;
  const UpdateProfile(this.updatedUser);
  @override
  List<Object?> get props => [updatedUser];
}
// Add this UpdateAvatar event for avatar file upload

class UpdateAvatar extends ProfileEvent {
  final AppUser user;
  final File avatarFile;
  const UpdateAvatar(this.user, this.avatarFile);
  @override
  List<Object?> get props => [user, avatarFile];
}
