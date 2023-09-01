import 'package:gameaway/data/repositories/base_repository.dart';
import '../Models/giveaway.dart';

class GiveawaysRepository extends BaseRepository {
  Future<List<Giveaway>> getValubaleGiveaways() async {
    List<Giveaway> data = [];
    List<dynamic> apiData = await super.getDatafromAPI(
        customURL:
            'https://www.gamerpower.com/api/giveaways?sort-by=value&type=game');
    for (var element in apiData) {
      data.add(Giveaway.fromJson(element));
    }
    return data;
  }

  Future<List<Giveaway>> getValubaleDLCs() async {
    List<Giveaway> data = [];
    List<dynamic> apiData = await super.getDatafromAPI(
        customURL:
            'https://www.gamerpower.com/api/giveaways?sort-by=value&type=loot');
    for (var element in apiData) {
      data.add(Giveaway.fromJson(element));
    }
    return data;
  }

  Future<List<Giveaway>> getGiveawaysbyPlatform(
      {required String platform}) async {
    List<Giveaway> data = [];
    List<dynamic> apiData = await super.getDatafromAPI(
        customURL:
            'https://www.gamerpower.com/api/giveaways?platform=$platform&type=game');
    for (var element in apiData) {
      data.add(Giveaway.fromJson(element));
    }
    return data;
  }

  Future<List<Giveaway>> getDlcsbyPlatform({required String platform}) async {
    List<Giveaway> data = [];
    List<dynamic> apiData = await super.getDatafromAPI(
        customURL:
            'https://www.gamerpower.com/api/giveaways?platform=$platform&type=loot');
    for (var element in apiData) {
      data.add(Giveaway.fromJson(element));
    }
    return data;
  }
}
