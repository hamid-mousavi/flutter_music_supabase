import 'package:music/data/Common/httpclient.dart';
import 'package:music/data/Services/song/Song_service.dart';
import 'package:music/data/model/song.dart';
import 'package:music/data/repository/i_song_repository.dart';

final songRepository = SongRepository(dataSource: SongSupaBaseDB());

class SongRepository implements ISongRepository {
  final ISongServices dataSource;

  SongRepository({required this.dataSource});

  @override
  Future<void> deleteData(int id) {
    return dataSource.deleteData(id);
  }

  @override
  Future<List<Song>> getAll() {
    return dataSource.getAll();
  }

  @override
  Future<List<Song>> getById(int id) {
    return dataSource.getById(id);
  }

  @override
  Future<List<Song>> getNews() {
    return dataSource.getNews();
  }

  @override
  Future<void> insertData(String title, String path, int artistId) {
    return dataSource.insertData(title, path, artistId);
  }

  @override
  Future<List<Song>> search(String param) {
    return dataSource.search(param);
  }

  @override
  Future<String> upladFile(String fileName, myFile) {
    return dataSource.upladFile(fileName, myFile);
  }
}
