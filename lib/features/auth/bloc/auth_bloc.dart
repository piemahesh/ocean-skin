import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/auth_repository.dart';
import '../../../core/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final user = await _repo.currentUser();
      user != null ? emit(Authenticated(user)) : emit(Unauthenticated());
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repo.login(event.email, event.password);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await _repo.logout();
      emit(Unauthenticated());
    });

    // Add registration/OAuth handling...
  }
}
