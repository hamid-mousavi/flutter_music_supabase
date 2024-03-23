import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music/data/Services/Auth/AuthService.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepostory authRepostory;
  AuthBloc(this.authRepostory) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginBtnClick) {
        emit(AuthLoading());
        try {
          await authRepostory.singIn(event.email, event.password);
          emit(AuthSuccess());
        } catch (e) {
          emit(AuthError(error: e.toString()));
        }
      }
    });
  }
}
