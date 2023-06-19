import 'package:gameaway/data/Models/giveaway.dart';

abstract class GiveawayFavoritesState {
  List<Giveaway> favorites;
  List<int> ids;
  GiveawayFavoritesState({required this.favorites, required this.ids});
}

class GiveawayFavoritesInitState extends GiveawayFavoritesState {
  GiveawayFavoritesInitState() : super(favorites: [], ids: []);
}

class GiveawayFavoritesLoadingState extends GiveawayFavoritesState {
  GiveawayFavoritesLoadingState() : super(favorites: [], ids: []);
}

class GiveawayFavoritesEmptyState extends GiveawayFavoritesState {
  GiveawayFavoritesEmptyState() : super(favorites: [], ids: []);
}

class GiveawayFavoritesSearchState extends GiveawayFavoritesState {
  GiveawayFavoritesSearchState({required super.favorites}) : super(ids: []);
}

class GiveawayFavoritesUpdateState extends GiveawayFavoritesState {
  GiveawayFavoritesUpdateState({required super.favorites, required super.ids});
}
