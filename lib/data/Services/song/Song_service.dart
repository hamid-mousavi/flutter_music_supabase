import 'dart:math';

import 'package:music/data/model/song.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String songTitle = 'soug_title';
const String songPath = 'song_path';
const String artistIdSong = 'artist_id';
const String createAt = 'created_at';

const String tableName = 'Song';

abstract class ISongServices {
  Future<List<Song>> getAll();
  Future<List<Song>> getNews();
  Future<List<Song>> getById(int id);
  Future<List<Song>> search(String param);
  Future<void> insertData(String title, String path, int artistId);
  Future<void> deleteData(int id);
  Future<String> upladFile(String fileName, dynamic myFile);
}

/*
class SongDataRemote implements ISongServices {
  final Dio httpClient;

  SongDataRemote({required this.httpClient});
  @override
  Future<List<Song>> getAll() async {
    final response = await httpClient.get('Song?select=*');
    List<Song> songs = [];
    var r = response.data;
    debugPrint(r.toString());
    (response.data as List).forEach((element) {
      songs.add(Song.fromJson(element));
    });
    return songs;
  }


*/
class SongSupaBaseDB implements ISongServices {
  final supabase = Supabase.instance.client;
  @override
  Future<List<Song>> getAll() async {
    final data = await supabase.from(tableName).select();
    List<Song> songs = [];
    data.forEach((element) {
      songs.add(Song.fromJson(element));
    });
    return songs;
  }

  @override
  Future<List<Song>> getById(int id) async {
    final data = await supabase.from(tableName).select().eq('id', id);
    List<Song> songs = [];
    data.forEach((element) {
      songs.add(Song.fromJson(element));
    });
    return songs;
  }

  @override
  Future<List<Song>> getNews() async {
    final data =
        await supabase.from(tableName).select().order(createAt).limit(3);

    List<Song> songs = [];
    data.forEach((element) {
      songs.add(Song.fromJson(element));
    });
    return songs;
  }

  @override
  Future<List<Song>> search(String param) async {
    final data =
        await supabase.from('Song').select().like(songTitle, '%$param%');
    List<Song> songs = [];
    data.forEach((element) {
      songs.add(Song.fromJson(element));
    });
    return songs;
  }

  @override
  Future<void> insertData(String title, String path, int artistId) async {
    await supabase
        .from(tableName)
        .insert({songTitle: title, songPath: path, artistIdSong: artistId});
  }

  @override
  Future<void> deleteData(int id) async {
    final result =
        await supabase.from(tableName).delete().match({'id': id}).select();
    if (result.isEmpty) {
      throw Exception('Error');
    }
  }

  @override
  Future<String> upladFile(String fileName, myFile) async {
    Random random = Random();
    final rand = random.nextInt(99999);
    String path = await supabase.storage.from('mybucket').uploadBinary(
          'public/${rand.toString() + fileName}',
          myFile!,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    return path;
  }
}
