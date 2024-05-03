import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/providers/base_repository.dart';

class FreetoPlayRepository extends BaseRepository {
  Future<List<FreetoPlay>> fetchData({String? category}) async {
    String url = 'https://www.freetogame.com/api/games';
    if (category != null) {
      url += '?category=$category';
    }
    List<dynamic> apiData = await super.getDatafromAPI(customURL: url);
    return apiData.map((e) => FreetoPlay.fromJson(e)).toList();
  }

  Future<List<FreetoPlay>> getAllFreetoPlay() async {
    return fetchData();
  }

  Future<List<FreetoPlay>> getfreetoplaybycategory(
      {required String category}) async {
    return fetchData(category: category);
  }
}
