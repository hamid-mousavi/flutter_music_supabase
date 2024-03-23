import 'package:music/data/model/song.dart';

abstract class ISongRepository {
  Future<List<Song>> getAll();
  Future<List<Song>> getNews();
  Future<List<Song>> getById(int id);
  Future<List<Song>> search(String param);
  Future<void> insertData(String title, String path, int artistId);
  Future<void> deleteData(int id);
}
