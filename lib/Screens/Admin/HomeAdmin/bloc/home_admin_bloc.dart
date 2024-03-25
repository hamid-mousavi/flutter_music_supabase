import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music/data/model/song.dart';
import 'package:music/data/repository/song_repository.dart';

part 'home_admin_event.dart';
part 'home_admin_state.dart';

class HomeAdminBloc extends Bloc<HomeAdminEvent, HomeAdminState> {
  final SongRepository repository;
  HomeAdminBloc(this.repository) : super(HomeAdminInitial()) {
    on<HomeAdminEvent>((event, emit) async {
      if (event is HomeAdminStarted) {
        emit(HomeAdminLoading());
        try {
          final songs = await repository.getAll();
          emit(HomeAdminSuccess(songs: songs));
        } catch (e) {
          emit(HomeAdminError(err: e.toString()));
        }
      } else if (event is HomeAdminDeleteItem) {
        // emit(HomeAdminLoading());
        try {
          final successState = (state as HomeAdminSuccess);
          final song = successState.songs
              .firstWhere((element) => element.id == event.itemId);
          song.deleteLoading = false;
          emit(HomeAdminSuccess(songs: successState.songs));
          await repository.deleteData(event.itemId);
          final items = await repository.getAll();
          emit(HomeAdminSuccess(songs: items));
        } catch (e) {
          emit(HomeAdminError(err: e.toString()));
        }
      }
    });
  }
}
