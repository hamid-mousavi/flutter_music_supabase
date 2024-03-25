import 'package:music/data/model/Artist.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String artistName = 'artist_name';
const String artistImage = 'image';
const String artistGenre = 'genre';
const String createAt = 'created_at';
const String tableName = 'Artist';

abstract class IArtistServices {
  Future<List<Artist>> getAll();
  Future<List<Artist>> getNews();
  Future<List<Artist>> getById(int id);
  Future<List<Artist>> search(String param);
  Future<void> insertData(String name, String image, String artistGenre);
  Future<void> deleteData(int id);
}

class ArtistSupaBaseDB implements IArtistServices {
  final supabase = Supabase.instance.client;
  @override
  Future<List<Artist>> getAll() async {
    final data = await supabase.from(tableName).select();
    List<Artist> artists = [];
    data.forEach((element) {
      artists.add(Artist.fromJson(element));
    });
    return artists;
  }

  @override
  Future<List<Artist>> getById(int id) async {
    final data = await supabase.from(tableName).select().eq('id', id);
    List<Artist> Artists = [];
    data.forEach((element) {
      Artists.add(Artist.fromJson(element));
    });
    return Artists;
  }

  @override
  Future<List<Artist>> getNews() async {
    final data =
        await supabase.from(tableName).select().order(createAt).limit(3);

    List<Artist> Artists = [];
    data.forEach((element) {
      Artists.add(Artist.fromJson(element));
    });
    return Artists;
  }

  @override
  Future<List<Artist>> search(String param) async {
    final data =
        await supabase.from('Artist').select().like(artistName, '%$param%');
    List<Artist> Artists = [];
    data.forEach((element) {
      Artists.add(Artist.fromJson(element));
    });
    return Artists;
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
  Future<void> insertData(String name, String image, String genre) async {
    await supabase
        .from(tableName)
        .insert({artistImage: image, artistName: name, artistGenre: genre});
  }
}
