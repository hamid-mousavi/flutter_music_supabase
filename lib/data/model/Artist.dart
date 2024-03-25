class Artist {
  int? id;
  String? createdAt;
  String? genre;
  String? artistName;
  String? image;

  bool deleteLoading = true;

  Artist({
    this.id,
    this.createdAt,
    this.genre,
    this.artistName,
    this.image,
  });

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    genre = json['genre'];
    artistName = json['artist_name'];
    image = json['image'];
  }
}
