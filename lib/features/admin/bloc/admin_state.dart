part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
}

class AdminInitial extends AdminState {
  @override
  List<Object?> get props => [];
}

class AdminLoading extends AdminState {
  @override
  List<Object?> get props => [];
}

class UsersLoaded extends AdminState {
  final List<AppUser> users;
  const UsersLoaded(this.users);
  List<Object?> get props => [users];
}

class ExportReady extends AdminState {
  final String csvData;
  const ExportReady(this.csvData);
  @override
  List<Object?> get props => [csvData];
}
