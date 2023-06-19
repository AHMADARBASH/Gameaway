import 'package:gameaway/data/Models/freetoplay.dart';

abstract class FreetoPlayFavoritesState {
  List<FreetoPlay> favorites;
  List<int> ids;
  FreetoPlayFavoritesState({required this.favorites, required this.ids});
}

class FreetoPlayFavoritesInitState extends FreetoPlayFavoritesState {
  FreetoPlayFavoritesInitState() : super(favorites: [], ids: []);
}

class FreetoPlayFavoritesLoadingState extends FreetoPlayFavoritesState {
  FreetoPlayFavoritesLoadingState() : super(favorites: [], ids: []);
}

class FreetoPlayFavoritesEmptyState extends FreetoPlayFavoritesState {
  FreetoPlayFavoritesEmptyState() : super(favorites: [], ids: []);
}

class FreetoPlayFavoritesUpdateState extends FreetoPlayFavoritesState {
  FreetoPlayFavoritesUpdateState(
      {required super.favorites, required super.ids});
}
