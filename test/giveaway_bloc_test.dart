import 'package:flutter_test/flutter_test.dart';
import 'package:gameaway/blocs/giveaways/giveaways_cubit.dart';
import 'package:gameaway/blocs/giveaways/giveaways_states.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/data/repositories/giveaways_repository.dart';
import 'package:gameaway/utilities/exceptions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockGiveawaysRepository extends Mock implements GiveawaysRepository {
  Future<List<Giveaway>> getGiveaways({required String customeUrl}) async {
    final url = Uri.parse(customeUrl);
    final response = await http.get(url);
    if (response.statusCode != 200) {
      if (response.statusCode == 201) {
        throw EmptyException(
            message: json.decode(response.body)['status_message']);
      } else {
        throw HTTPException(message: 'Server Error');
      }
    }
    final responseData = json.decode(response.body);
    List<Giveaway> giveawaysList = [];
    for (int i = 0; i < responseData.length; i++) {
      giveawaysList.add(Giveaway.fromJson(responseData[i]));
    }
    return giveawaysList;
  }
}

void main() {
  late GiveawaysCubit sut;
  late MockGiveawaysRepository mockRepo;

  setUp(() {
    mockRepo = MockGiveawaysRepository();
    sut = GiveawaysCubit();
  });
  test('check cubit inital values', () {
    expect(sut.isInit, false);
  });
  test('test repository requests', () async {
    expect(
        await mockRepo.getGiveaways(
            customeUrl:
                'https://www.gamerpower.com/api/giveaways?sort-by=value&type=game'),
        isA<List<Giveaway>>());
  });

  test('check is Loading State has been indicates', () async {
    expect(
        await mockRepo.getGiveaways(
            customeUrl:
                'https://www.gamerpower.com/api/giveaways?sort-by=value&type=game'),
        isA<List<Giveaway>>());
    final future = sut.getValuableGiveaways();
    expect(sut.state, isA<GiveawayLoadingState>());
    await future;
    expect(sut.state, isA<GiveawayUpdateState>());
  });

  test('check calls count', () async {
    await mockRepo.getValubaleGiveaways();
    verify(
      () => mockRepo.getValubaleGiveaways(),
    ).called(1);
  });
}
