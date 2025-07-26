import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/profile_repository.dart';
import '../../../core/models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repo;
  ProfileBloc(this._repo) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final user = await _repo.getProfile(event.userId);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('Profile not found'));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileUpdating());
      await _repo.updateProfile(event.updatedUser);
      emit(ProfileUpdated());
      add(LoadProfile(event.updatedUser.id));
    });
    on<UpdateAvatar>((event, emit) async {
      emit(ProfileUpdating());
      try {
        await _repo.updateAvatar(event.user, event.avatarFile);
        emit(ProfileUpdated());
        add(LoadProfile(event.user.id)); // reload updated profile
      } catch (e) {
        emit(ProfileError('Failed to update avatar: ${e.toString()}'));
      }
    });
  }
}
