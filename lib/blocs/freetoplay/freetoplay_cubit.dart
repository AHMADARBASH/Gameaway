import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_states.dart';
import 'package:gameaway/data/repositories/freetoplay_repository.dart';
import 'package:gameaway/utilities/exceptions.dart';

class FreetoPlayCubit extends Cubit<FreetoPlayState> {
  //
  FreetoPlayCubit()
      : super(FreetoPlayInitState(
          freetoplay: [],
        ));

  final repo = FreetoPlayRepository();
  bool isInit = false;
  Future<void> getFreetoplay() async {
    emit(FreetoPlayLoadingState());
    try {
      final data = await repo.getAllFreetoPlay();
      isInit = true;
      emit(FreetoPlayUpadateState(freetoplay: data));
    } on EmptyException catch (e) {
      emit(FreetoPlayEmptyState(emptyMessage: e.message));
    } on HTTPException catch (e) {
      emit(FreetoPlayErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(FreetoPlayErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      emit(FreetoPlayErrorState(errorMessage: 'Unkown Error'));
    }
  }

  Future<void> getFreetoPlaybyCategory({required String category}) async {
    emit(FreetoPlayLoadingState());
    try {
      final data = await repo.getfreetoplaybycategory(category: category);
      isInit = true;
      emit(FreetoPlayUpadateState(
        freetoplay: data,
      ));
    } on EmptyException catch (e) {
      emit(FreetoPlayEmptyState(emptyMessage: e.message));
    } on HTTPException catch (e) {
      emit(FreetoPlayErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(FreetoPlayErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      emit(FreetoPlayErrorState(errorMessage: _.toString()));
    }
  }
}
