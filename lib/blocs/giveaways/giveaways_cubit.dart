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
  Future<void> getValuableGiveaways() async {
    emit(GiveawayLoadingState());
    try {
      final data = await _repo.getValubaleGiveaways();
      isInit = true;
      emit(GiveawayUpdateState(giveaways: data));
    } on EmptyException catch (e) {
      emit(GiveawayEmptyState(emptyMessage: e.message));
    } on HTTPException catch (e) {
      emit(GiveawayErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(GiveawayErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      emit(GiveawayErrorState(errorMessage: 'Unkown Error'));
    }
  }

  Future<void> getGiveawaysbyPlatform({required String platform}) async {
    emit(GiveawayLoadingState());
    try {
      final data = await _repo.getGiveawaysbyPlatform(platform: platform);
      isInit = true;
      emit(GiveawayUpdateState(
        giveaways: data,
      ));
    } on EmptyException catch (e) {
      emit(GiveawayEmptyState(emptyMessage: e.message));
    } on HTTPException catch (e) {
      emit(GiveawayErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(GiveawayErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      emit(GiveawayErrorState(errorMessage: _.toString()));
    }
  }
}
