import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music/data/model/song.dart';
import 'package:music/data/repository/i_song_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ISongRepository songRepository;
  HomeBloc(this.songRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        final lastSongs = await songRepository.getNews();
        emit(HomeSuccess(lastSongs: lastSongs));
      }
    });
  }
}
