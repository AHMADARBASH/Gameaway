import 'package:gameaway/data/repositories/base_repository.dart';
import '../Models/giveaway.dart';

class GiveawaysRepository extends BaseRepository {
  Future<List<Giveaway>> getValubaleGiveaways() async {
    final data = await super.getGiveaways(
        customeUrl:
            'https://www.gamerpower.com/api/giveaways?sort-by=value&type=game');
    return data;
  }

  Future<List<Giveaway>> getValubaleDLCs() async {
    final data = await super.getGiveaways(
        customeUrl:
            'https://www.gamerpower.com/api/giveaways?sort-by=value&type=loot');
    return data;
  }

  Future<List<Giveaway>> getGiveawaysbyPlatform(
      {required String platform}) async {
    final data = super.getGiveaways(
        customeUrl:
            'https://www.gamerpower.com/api/giveaways?platform=$platform&type=game');
    return data;
  }

  Future<List<Giveaway>> getDlcsbyPlatform({required String platform}) async {
    final data = await super.getGiveaways(
        customeUrl:
            'https://www.gamerpower.com/api/giveaways?platform=$platform&type=loot');
    return data;
  }
}
