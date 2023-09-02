import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/repositories/base_repository.dart';

class FreetoPlayRepository extends BaseRepository {
  Future<List<FreetoPlay>> _getFreetoPlayByCategory({String? category}) async {
    List<FreetoPlay> data = [];
    String url = 'https://www.freetogame.com/api/games';

    if (category != null) {
      url += '?category=$category';
    }

    List<dynamic> apiData = await super.getDatafromAPI(customURL: url);

    for (var element in apiData) {
      data.add(FreetoPlay.fromJson(element));
    }
    return data;
  }

  Future<List<FreetoPlay>> getAllFreetoPlay() async {
    return _getFreetoPlayByCategory();
  }

  Future<List<FreetoPlay>> getfreetoplaybycategory(
      {required String category}) async {
    return _getFreetoPlayByCategory(category: category);
  }
}
