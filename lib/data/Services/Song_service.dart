import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/data/model/song.dart';

abstract class ISongServices {
  Future<List<Song>> getAll();
  Future<List<Song>> getNews();
}

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
      (a, b) => a.createdAt!.compareTo(b.createdAt!),
    );
    songs = [];
    for (var i = 0; i < 2; i++) {
      songs.add(songs[i]);
    }
    return songs;
  }
}
