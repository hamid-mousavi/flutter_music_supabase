part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginBtnClick extends AuthEvent {
  final String email;
  final String password;

  LoginBtnClick({required this.email, required this.password});
}

class AuthStarted extends AuthEvent {}
