part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Song> lastSongs;

  HomeSuccess({required this.lastSongs});
}
