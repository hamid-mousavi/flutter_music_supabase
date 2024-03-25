part of 'add_song_bloc.dart';

@immutable
sealed class AddSongEvent {}

class AddSongStarted extends AddSongEvent {}

class BrowseBtnClick extends AddSongEvent {
  final String path;

  BrowseBtnClick({required this.path});
}

class BtnSaveClick extends AddSongEvent {
  final dynamic myFile;
  final String fileName;

  final int artistId;
  final String title;

  BtnSaveClick(
      {required this.myFile,
      required this.fileName,
      required this.artistId,
      required this.title});
}
