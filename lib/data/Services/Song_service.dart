
import 'package:dio/dio.dart';
import 'package:music/data/model/song.dart';




abstract class ISongServices{
  Future<List<Song>> getAll();

}
class SongDataRemote implements ISongServices{
  final Dio httpClient;

  SongDataRemote({required this.httpClient});
  @override
  Future<List<Song>> getAll() async{
   final response = await httpClient.get('Song?select=*');
   List<Song> songs = [];
   (response.data as List).forEach((element) {
    songs.add(Song.fromJson(element));
   });
   return songs;
  }

}
