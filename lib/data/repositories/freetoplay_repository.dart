import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/repositories/base_repository.dart';

class FreetoPlayRepository extends BaseRepository {
  Future<List<FreetoPlay>> getAllFreetoPlay() async {
    final data = await super
        .getfreetoplay(customeUrl: 'https://www.freetogame.com/api/games');
    return data;
  }

  Future<List<FreetoPlay>> getfreetoplaybycategory(
      {required String category}) async {
    final data = await super.getfreetoplay(
        customeUrl: 'https://www.freetogame.com/api/games?category=$category');
    return data;
  }
}
