import 'package:gameaway/data/Models/giveaway.dart';

abstract class GiveawaysState {
  List<Giveaway> giveaways;
  GiveawaysState({
    required this.giveaways,
  });
}

class GiveawayInitState extends GiveawaysState {
  GiveawayInitState({required super.giveaways});
}

class GiveawayUpdateState extends GiveawaysState {
  GiveawayUpdateState({required super.giveaways});
}

class GiveawayLoadingState extends GiveawaysState {
  GiveawayLoadingState() : super(giveaways: []);
}

class GiveawayErrorState extends GiveawaysState {
  String errorMessage;
  GiveawayErrorState({required this.errorMessage}) : super(giveaways: []);
}

class GiveawayEmptyState extends GiveawaysState {
  String emptyMessage;
  GiveawayEmptyState({required this.emptyMessage}) : super(giveaways: []);
}
