import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_states.dart';
import 'package:gameaway/data/repositories/freetoplay_repository.dart';
import 'package:gameaway/utilities/exceptions.dart';

class FreetoPlayCubit extends Cubit<FreetoPlayState> {
  //
  FreetoPlayCubit() : super(FreetoPlayInitState(freetoplay: []));

  final repo = FreetoPlayRepository();

  bool isInit = false;

  Future<void> errorHandler(dynamic error) async {
    if (error is EmptyException) {
      emit(FreetoPlayEmptyState(emptyMessage: error.message));
    } else if (error is HTTPException) {
      emit(FreetoPlayErrorState(errorMessage: error.message));
    } else if (error is SocketException) {
      emit(FreetoPlayErrorState(errorMessage: 'Connection Error'));
    } else {
      emit(FreetoPlayErrorState(errorMessage: 'Unknown Error'));
    }
  }

  Future<void> getFreetoplay() async {
    emit(FreetoPlayLoadingState());
    try {
      final data = await repo.getAllFreetoPlay();
      isInit = true;
      emit(FreetoPlayUpadateState(freetoplay: data));
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> getFreetoPlaybyCategory({required String category}) async {
    emit(FreetoPlayLoadingState());
    try {
      final data = await repo.getfreetoplaybycategory(category: category);
      isInit = true;
      emit(FreetoPlayUpadateState(freetoplay: data));
    } catch (e) {
      errorHandler(e);
    }
  }
}
