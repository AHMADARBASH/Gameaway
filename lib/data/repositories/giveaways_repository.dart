import 'package:gameaway/data/repositories/base_repository.dart';
import '../Models/giveaway.dart';

class GiveawaysRepository extends BaseRepository {
  Future<List<Giveaway>> _getGiveawaysByType(String type,
      {String? platform}) async {
    List<Giveaway> data = [];
    String url =
        'https://www.gamerpower.com/api/giveaways?sort-by=value&type=$type';

    if (platform != null) {
      url += '&platform=$platform';
    }

    List<dynamic> apiData = await super.getDatafromAPI(customURL: url);

    for (var element in apiData) {
      data.add(Giveaway.fromJson(element));
    }
    return data;
  }

  Future<List<Giveaway>> getValubaleGiveaways() async {
    return _getGiveawaysByType('game');
  }

  Future<List<Giveaway>> getValubaleDLCs() async {
    return _getGiveawaysByType('loot');
  }

  Future<List<Giveaway>> getGiveawaysbyPlatform(
      {required String platform}) async {
    return _getGiveawaysByType('game', platform: platform);
  }

  Future<List<Giveaway>> getDlcsbyPlatform({required String platform}) async {
    return _getGiveawaysByType('loot', platform: platform);
  }
}
