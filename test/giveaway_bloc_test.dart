import 'package:flutter_test/flutter_test.dart';
import 'package:gameaway/blocs/giveaways/giveaways_cubit.dart';
import 'package:gameaway/blocs/giveaways/giveaways_states.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/data/repositories/giveaways_repository.dart';

void main() {
  late GiveawaysCubit sut;
  late GiveawaysRepository mockRepo;

  setUp(() {
    mockRepo = GiveawaysRepository();
    sut = GiveawaysCubit();
  });
  group("Giveaway Repo Test", () {
    test('check cubit inital values', () {
      expect(sut.isInit, false);
    });
    test('test repository requests', () async {
      var list = await mockRepo.getValubaleGiveaways();
      expect(list, isA<List<Giveaway>>());
    });

    test('check is Loading State has been indicates', () async {
      expect(await mockRepo.getValubaleGiveaways(), isA<List<Giveaway>>());
      final future = sut.getValuableGiveaways();
      expect(sut.state, isA<GiveawayLoadingState>());
      await future;
      expect(sut.state, isA<GiveawayUpdateState>());
    });
  });
}
