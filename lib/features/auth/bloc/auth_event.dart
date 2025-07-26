// auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email, password;
  const LoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RegistrationRequested extends AuthEvent {
  final String email, password, username;
  const RegistrationRequested({
    required this.email,
    required this.password,
    required this.username,
  });
  @override
  List<Object?> get props => [email, password, username];
}

class RegistrationDetailsProvided extends AuthEvent {
  final String phone, dob, name;
  const RegistrationDetailsProvided({
    required this.phone,
    required this.dob,
    required this.name,
  });
  @override
  List<Object?> get props => [phone, dob, name];
}

class AvatarUploaded extends AuthEvent {
  final String? avatarPath;
  const AvatarUploaded({this.avatarPath});
  @override
  List<Object?> get props => [avatarPath];
}

// More: RegistrationRequested, OAuthSignInRequested, etc.
