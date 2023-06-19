class FreetoPlay {
  late int id;
  late String title;
  late String thumbnail;
  late String shortDescription;
  late String gameUrl;
  late String genre;
  late String platform;
  late String publisher;
  late String developer;
  late String releaseDate;
  late String freetogameProfileUrl;

  FreetoPlay(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.shortDescription,
      required this.gameUrl,
      required this.genre,
      required this.platform,
      required this.publisher,
      required this.developer,
      required this.releaseDate,
      required this.freetogameProfileUrl});

  FreetoPlay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    shortDescription = json['short_description'];
    gameUrl = json['game_url'];
    genre = json['genre'];
    platform = json['platform'];
    publisher = json['publisher'];
    developer = json['developer'];
    releaseDate = json['release_date'];
    freetogameProfileUrl = json['freetogame_profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['short_description'] = shortDescription;
    data['game_url'] = gameUrl;
    data['genre'] = genre;
    data['platform'] = platform;
    data['publisher'] = publisher;
    data['developer'] = developer;
    data['release_date'] = releaseDate;
    data['freetogame_profile_url'] = freetogameProfileUrl;
    return data;
  }
}
