part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
}

class LoadUsers extends AdminEvent {
  @override
  List<Object?> get props => [];
}

class BlockUser extends AdminEvent {
  final String userId;
  const BlockUser(this.userId);
  @override
  List<Object?> get props => [userId];
}

class SetPostingAccess extends AdminEvent {
  final String userId;
  final bool canPost;
  const SetPostingAccess(this.userId, this.canPost);
  @override
  List<Object?> get props => [userId, canPost];
}

class ExportCsv extends AdminEvent {
  @override
  List<Object?> get props => [];
}
