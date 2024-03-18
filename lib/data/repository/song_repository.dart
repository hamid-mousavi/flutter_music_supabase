import 'package:music/data/Common/httpclient.dart';
import 'package:music/data/Services/Song_service.dart';
import 'package:music/data/model/song.dart';
import 'package:music/data/repository/i_song_repository.dart';

final songRepository =
    SongRepository(dataSource: SongDataRemote(httpClient: httpClient));

class SongRepository implements ISongRepository {
  final ISongServices dataSource;

  SongRepository({required this.dataSource});
  @override
  Future<List<Song>> getAll() async {
    return dataSource.getAll();
  }

  @override
  Future<List<Song>> getNews() async {
    return dataSource.getNews();
  }
}
