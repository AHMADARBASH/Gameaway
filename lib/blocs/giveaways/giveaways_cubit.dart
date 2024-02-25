import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/giveaways/giveaways_states.dart';
import 'package:gameaway/utilities/exceptions.dart';
import '../../data/repositories/giveaways_repository.dart';

class GiveawaysCubit extends Cubit<GiveawaysState> {
  //
  GiveawaysCubit() : super(GiveawayInitState(giveaways: []));

  final _repo = GiveawaysRepository();

  bool isInit = false;

  Future<void> errorHandler(dynamic error) async {
    if (error is EmptyException) {
      emit(GiveawayEmptyState(emptyMessage: error.message));
    } else if (error is HTTPException) {
      emit(GiveawayErrorState(errorMessage: error.message));
    } else if (error is SocketException) {
      emit(GiveawayErrorState(errorMessage: 'Connection Error'));
    } else {
      emit(GiveawayErrorState(errorMessage: 'Unknown Error'));
    }
  }

  Future<void> getValuableGiveaways() async {
    emit(GiveawayLoadingState());
    try {
      final data = await _repo.getValubaleGiveaways();
      isInit = true;
      emit(GiveawayUpdateState(giveaways: data));
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> getGiveawaysbyPlatform({required String platform}) async {
    emit(GiveawayLoadingState());
    try {
      final data = await _repo.getGiveawaysbyPlatform(platform: platform);
      isInit = true;
      emit(GiveawayUpdateState(giveaways: data));
    } catch (e) {
      errorHandler(e);
    }
  }
}
