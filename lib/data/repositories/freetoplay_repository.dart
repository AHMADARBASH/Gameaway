import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/repositories/base_repository.dart';

class FreetoPlayRepository extends BaseRepository {
  Future<List<FreetoPlay>> getAllFreetoPlay() async {
    List<FreetoPlay> data = [];
    List<dynamic> apiData = await super
        .getDatafromAPI(customURL: 'https://www.freetogame.com/api/games');
    for (var element in apiData) {
      data.add(FreetoPlay.fromJson(element));
    }
    return data;
  }

  Future<List<FreetoPlay>> getfreetoplaybycategory(
      {required String category}) async {
    List<FreetoPlay> data = [];
    List<dynamic> apiData = await super.getDatafromAPI(
        customURL: 'https://www.freetogame.com/api/games?category=$category');
    for (var element in apiData) {
      data.add(FreetoPlay.fromJson(element));
    }
    return data;
  }
}
