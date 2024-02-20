import 'package:gameaway/data/repositories/base_repository.dart';
import '../Models/giveaway.dart';

class GiveawaysRepository extends BaseRepository {
  Future<List<Giveaway>> fetchData(String type, {String? platform}) async {
    String url =
        'https://www.gamerpower.com/api/giveaways?sort-by=value&type=$type';
    if (platform != null) {
      url += '&platform=$platform';
    }
    List<dynamic> apiData = await super.getDatafromAPI(customURL: url);
    return apiData.map((e) => Giveaway.fromJson(e)).toList();
  }

  Future<List<Giveaway>> getValubaleGiveaways() async {
    return fetchData('game');
  }

  Future<List<Giveaway>> getValubaleDLCs() async {
    return fetchData('loot');
  }

  Future<List<Giveaway>> getGiveawaysbyPlatform(
      {required String platform}) async {
    return fetchData('game', platform: platform);
  }

  Future<List<Giveaway>> getDlcsbyPlatform({required String platform}) async {
    return fetchData('loot', platform: platform);
  }
}
