import 'package:music/data/Services/Artist/Artist_Service.dart';
import 'package:music/data/model/Artist.dart';

abstract class IArtistRepository {
  Future<List<Artist>> getAll();
  Future<List<Artist>> getNews();
  Future<List<Artist>> getById(int id);
  Future<List<Artist>> search(String param);
  Future<void> insertData(String name, String image, String artistGenre);
  Future<void> deleteData(int id);
}

final artistRepository = ArtistRepository(services: ArtistSupaBaseDB());

class ArtistRepository implements IArtistRepository {
  final IArtistServices services;

  ArtistRepository({required this.services});
  @override
  Future<void> deleteData(int id) {
    return services.deleteData(id);
  }

  @override
  Future<List<Artist>> getAll() {
    return services.getAll();
  }

  @override
  Future<List<Artist>> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Artist>> getNews() {
    // TODO: implement getNews
    throw UnimplementedError();
  }

  @override
  Future<void> insertData(String name, String image, String artistGenre) {
    // TODO: implement insertData
    throw UnimplementedError();
  }

  @override
  Future<List<Artist>> search(String param) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
