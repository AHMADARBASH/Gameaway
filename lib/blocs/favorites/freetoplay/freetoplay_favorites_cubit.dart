import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_states.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/providers/helpers/database_helper.dart';

class FreetoPlayFavoritesCubit extends Cubit<FreetoPlayFavoritesState> {
  FreetoPlayFavoritesCubit() : super(FreetoPlayFavoritesInitState());
  List<FreetoPlay> favorites = [];
  List<int> ids = [];
  Future<void> getFavorites() async {
    emit(FreetoPlayFavoritesLoadingState());
    List<Map<String, dynamic>> data =
        await DatabaseHelper.getDatafromDatabase(tableName: 'freetoplay');
    if (data.isEmpty) {
      emit(FreetoPlayFavoritesEmptyState());
    } else {
      data.map((e) {
        favorites.add(FreetoPlay.fromJson(e));
        ids.add(e['id']);
      });
      emit(FreetoPlayFavoritesUpdateState(favorites: favorites, ids: ids));
    }
  }

  Future<void> addFavorite({required FreetoPlay freetoplay}) async {
    emit(FreetoPlayFavoritesLoadingState());
    await DatabaseHelper.insertIntoDatabase(tableName: 'freetoplay', data: {
      'id': freetoplay.id,
      'title': freetoplay.title,
      'thumbnail': freetoplay.thumbnail,
      'short_description': freetoplay.shortDescription,
      'game_url': freetoplay.gameUrl,
      'genre': freetoplay.genre,
      'platform': freetoplay.platform,
      'publisher': freetoplay.publisher,
      'developer': freetoplay.developer,
      'release_date': freetoplay.releaseDate,
      'freetogame_profile_url': freetoplay.freetogameProfileUrl,
    });
    favorites.add(freetoplay);
    ids.add(freetoplay.id);
    emit(FreetoPlayFavoritesUpdateState(favorites: favorites, ids: ids));
  }

  Future<void> removeFavorite({required int id}) async {
    emit(FreetoPlayFavoritesLoadingState());
    await DatabaseHelper.deletefromDatabase(id: id, tableName: 'freetoplay');
    favorites.removeWhere(
      (element) => element.id == id,
    );
    ids.removeWhere(
      (element) => element == id,
    );
    if (favorites.isEmpty) {
      emit(FreetoPlayFavoritesEmptyState());
    } else {
      emit(FreetoPlayFavoritesUpdateState(favorites: favorites, ids: ids));
    }
  }
}
