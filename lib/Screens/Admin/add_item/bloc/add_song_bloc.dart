import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';
import 'package:music/data/model/Artist.dart';
import 'package:music/data/repository/Artist/ArtistRepository.dart';
import 'package:music/data/repository/song_repository.dart';

part 'add_song_event.dart';
part 'add_song_state.dart';

class AddSongBloc extends Bloc<AddSongEvent, AddSongState> {
  final ArtistRepository artistRepository;
  final SongRepository songRepository;
  AddSongBloc(this.artistRepository, this.songRepository)
      : super(AddSongInitial()) {
    on<AddSongEvent>((event, emit) async {
      emit(LoadingArtist());
      if (event is AddSongStarted) {
        try {
          final artists = await artistRepository.getAll();
          emit(LoadArtistSuccess(artists: artists));
        } catch (e) {
          emit(ErrorLoadArtist(error: e.toString()));
        }
      } else if (event is BrowseBtnClick) {
      } else if (event is BtnSaveClick) {
        try {
          String path =
              await songRepository.upladFile(event.fileName, event.myFile);
          await songRepository.insertData(event.title, path, event.artistId);
          emit(BtnSaveSuccess(path: path));
        } catch (e) {}
      }
    });
  }
}
