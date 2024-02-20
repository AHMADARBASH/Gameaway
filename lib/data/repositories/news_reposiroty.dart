import 'package:gameaway/data/Models/news.dart';
import 'package:gameaway/data/repositories/base_repository.dart';

class NewsRepository extends BaseRepository {
  Future<List<News>> getAllNews() async {
    List<dynamic> apiData = await super
        .getDatafromAPI(customURL: 'https://www.mmobomb.com/api1/latestnews');
    return apiData.map((e) => News.fromJson(e)).toList();
  }
}
