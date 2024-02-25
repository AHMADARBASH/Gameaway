import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_states.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/data/helpers/database_helper.dart';

class GiveawayFavoritesCubit extends Cubit<GiveawayFavoritesState> {
  GiveawayFavoritesCubit() : super(GiveawayFavoritesInitState());
  List<Giveaway> favorites = [];
  List<int> ids = [];
  Future<void> getFavorites() async {
    emit(GiveawayFavoritesLoadingState());
    List<Map<String, dynamic>> data =
        await DatabaseHelper.getDatafromDatabase(tableName: 'giveaway');
    if (data.isEmpty) {
      emit(GiveawayFavoritesEmptyState());
    } else {
      data.map((e) {
        favorites.add(Giveaway.fromJson(e));
        ids.add(e['id']);
      });

      emit(GiveawayFavoritesUpdateState(favorites: favorites, ids: ids));
    }
  }

  Future<void> addFavorite({required Giveaway giveaway}) async {
    emit(GiveawayFavoritesLoadingState());
    await DatabaseHelper.insertIntoDatabase(tableName: 'giveaway', data: {
      'id': giveaway.id,
      'title': giveaway.title,
      'worth': giveaway.worth,
      'thumbnail': giveaway.thumbnail,
      'image': giveaway.image,
      'description': giveaway.description,
      'instructions': giveaway.instructions,
      'open_giveaway_url': giveaway.openGiveaway,
      'published_date': giveaway.publishedDate,
      'type': giveaway.type,
      'platforms': giveaway.platforms,
      'end_date': giveaway.endDate,
      'users': giveaway.users,
      'status': giveaway.status,
      'gamerpower_url': giveaway.gamerpowerUrl,
      'open_giveaway': giveaway.openGiveaway,
    });
    favorites.add(giveaway);
    ids.add(giveaway.id);
    emit(GiveawayFavoritesUpdateState(favorites: favorites, ids: ids));
  }

  Future<void> removeFavorite({required int id}) async {
    emit(GiveawayFavoritesLoadingState());
    await DatabaseHelper.deletefromDatabase(id: id, tableName: 'giveaway');
    favorites.removeWhere(
      (element) => element.id == id,
    );
    ids.removeWhere(
      (element) => element == id,
    );
    if (favorites.isEmpty) {
      emit(GiveawayFavoritesEmptyState());
    } else {
      emit(GiveawayFavoritesUpdateState(favorites: favorites, ids: ids));
    }
  }
}
