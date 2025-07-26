import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/admin_repository.dart';
import '../../../core/models/user.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _repo;
  AdminBloc(this._repo) : super(AdminInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(AdminLoading());
      final users = await _repo.getAllUsers();
      emit(UsersLoaded(users));
    });

    on<BlockUser>((event, emit) async {
      await _repo.blockUser(event.userId);
      add(LoadUsers());
    });

    on<SetPostingAccess>((event, emit) async {
      await _repo.setPostingAccess(event.userId, event.canPost);
      add(LoadUsers());
    });

    on<ExportCsv>((event, emit) async {
      final csvData = await _repo.exportUsersAsCsv();
      emit(ExportReady(csvData));
    });
  }
}
