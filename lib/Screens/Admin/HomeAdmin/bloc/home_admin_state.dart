part of 'home_admin_bloc.dart';

@immutable
sealed class HomeAdminState {}

final class HomeAdminInitial extends HomeAdminState {}

final class HomeAdminSuccess extends HomeAdminState {
  final List<Song> songs;

  HomeAdminSuccess({required this.songs});
}

final class HomeAdminDeleteItemSuccess extends HomeAdminState {
  final List<Song> songs;

  HomeAdminDeleteItemSuccess({required this.songs});
}

final class HomeAdminDeleteItemError extends HomeAdminState {
  final String error;

  HomeAdminDeleteItemError({required this.error});
}

final class HomeAdminError extends HomeAdminState {
  final String err;

  HomeAdminError({required this.err});
}

final class HomeAdminLoading extends HomeAdminState {}
