import 'package:gameaway/data/Models/news.dart';
import 'package:gameaway/data/repositories/base_repository.dart';

class NewsRepository extends BaseRepository {
  Future<List<News>> getAllNews() async {
    final data = await super
        .getNews(cutsomeUrl: 'https://www.mmobomb.com/api1/latestnews');
    return data;
  }
}
