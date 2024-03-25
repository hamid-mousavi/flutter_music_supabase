part of 'home_admin_bloc.dart';

@immutable
sealed class HomeAdminEvent {}

class HomeAdminStarted extends HomeAdminEvent {}

class HomeAdminDeleteItem extends HomeAdminEvent {
  final int itemId;

  HomeAdminDeleteItem({required this.itemId});
}

class HomeAdminEditItem extends HomeAdminEvent {
  final int itemId;

  HomeAdminEditItem({required this.itemId});
}

class HomeAdminAddItem extends HomeAdminEvent {}
