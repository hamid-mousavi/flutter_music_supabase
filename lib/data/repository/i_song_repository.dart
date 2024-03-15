import 'package:music/data/model/song.dart';

abstract class ISongRepository{
  Future<List<Song>> getAll();

}