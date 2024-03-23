import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Future<List<Song>> getNews() async {
    final response = await httpClient.get('Song?select=*');
    List<Song> songs = [];
    (response.data as List).forEach((element) {
      songs.add(Song.fromJson(element));
    });
    songs.sort(
      (a, b) => -a.createdAt!.compareTo(b.createdAt!),
    );

    List<Song> songs2 = [];
    for (var i = 0; i < 2; i++) {
      songs2.add(songs[i]);
    }
    return songs2;
  }

  @override
  Future<Song> getById(int id) async {
    final response = await httpClient.get(
        'https://ifbdbzawjrqdxbuojwbk.supabase.co/rest/v1/Song?select=*&id=eq.$id');
    return Song.fromJson(response.data);
  }

  @override
  Future<List<Song>> search(String param) async {
    final response = await httpClient.get('Song?select=*');
    List<Song> songs = [];
    (response.data as List).forEach((element) {
      songs.add(Song.fromJson(element));
    });
    List<Song> result =
        songs.where((element) => element.sougTitle!.contains(param)).toList();
    return result;
  }

  @override
  Future<AuthResponse> singIn(String email, String password) {
    // TODO: implement singIn
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> singUp(String email, String password) {
    // TODO: implement singUp
    throw UnimplementedError();
  }

  @override
  Future<void> insertData(String title, String path, int artistId) {
    // TODO: implement insertData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
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
    await supabase.from(tableName).delete().match({'id': id});
  }
}
