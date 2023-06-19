class Giveaway {
  late int id;
  late String title;
  late String worth;
  late String thumbnail;
  late String image;
  late String description;
  late String instructions;
  late String openGiveawayUrl;
  late String publishedDate;
  late String type;
  late String platforms;
  late String endDate;
  late int users;
  late String status;
  late String gamerpowerUrl;
  late String openGiveaway;

  Giveaway(
      {required this.id,
      required this.title,
      required this.worth,
      required this.thumbnail,
      required this.image,
      required this.description,
      required this.instructions,
      required this.openGiveawayUrl,
      required this.publishedDate,
      required this.type,
      required this.platforms,
      required this.endDate,
      required this.users,
      required this.status,
      required this.gamerpowerUrl,
      required this.openGiveaway});

  Giveaway.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    worth = json['worth'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    description = json['description'];
    instructions = json['instructions'];
    openGiveawayUrl = json['open_giveaway_url'];
    publishedDate = json['published_date'];
    type = json['type'];
    platforms = json['platforms'];
    endDate = json['end_date'];
    users = json['users'];
    status = json['status'];
    gamerpowerUrl = json['gamerpower_url'];
    openGiveaway = json['open_giveaway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['worth'] = worth;
    data['thumbnail'] = thumbnail;
    data['image'] = image;
    data['description'] = description;
    data['instructions'] = instructions;
    data['open_giveaway_url'] = openGiveawayUrl;
    data['published_date'] = publishedDate;
    data['type'] = type;
    data['platforms'] = platforms;
    data['end_date'] = endDate;
    data['users'] = users;
    data['status'] = status;
    data['gamerpower_url'] = gamerpowerUrl;
    data['open_giveaway'] = openGiveaway;
    return data;
  }
}
