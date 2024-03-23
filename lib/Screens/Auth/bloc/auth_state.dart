part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}

class AuthLoading extends AuthState {}
