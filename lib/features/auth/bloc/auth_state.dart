// auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final AppUser user;
  const Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class RegistrationStepCredentials extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegistrationStepProfile extends AuthState {
  final String email, password, username;
  const RegistrationStepProfile(this.email, this.password, this.username);
  @override
  List<Object?> get props => [email, password, username];
}

class RegistrationStepAvatar extends AuthState {
  final String email, password, username, phone, dob, name;
  const RegistrationStepAvatar(
    this.email,
    this.password,
    this.username,
    this.phone,
    this.dob,
    this.name,
  );
  @override
  List<Object?> get props => [email, password, username, phone, dob, name];
}
