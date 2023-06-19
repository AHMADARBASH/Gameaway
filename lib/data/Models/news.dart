class News {
  late int id;
  late String title;
  late String shortDescription;
  late String thumbnail;
  late String mainImage;
  late String articleContent;
  late String articleUrl;

  News({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.thumbnail,
    required this.mainImage,
    required this.articleContent,
    required this.articleUrl,
  });

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    thumbnail = json['thumbnail'];
    mainImage = json['main_image'];
    articleContent = json['article_content'];
    articleUrl = json['article_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['thumbnail'] = thumbnail;
    data['main_image'] = mainImage;
    data['article_content'] = articleContent;
    data['article_url'] = articleUrl;
    return data;
  }
}
