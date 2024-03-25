part of 'add_song_bloc.dart';

@immutable
sealed class AddSongState {}

final class AddSongInitial extends AddSongState {}

final class LoadArtistSuccess extends AddSongState {
  final List<Artist> artists;

  LoadArtistSuccess({required this.artists});
}

final class ErrorLoadArtist extends AddSongState {
  final String error;

  ErrorLoadArtist({required this.error});
}

final class LoadingArtist extends AddSongState {}

final class BtnSaveSuccess extends AddSongState {
  final String path;

  BtnSaveSuccess({required this.path});
}
