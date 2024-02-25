import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/DLCs/dlcs_states.dart';
import '../../data/repositories/giveaways_repository.dart';
import 'package:gameaway/utilities/exceptions.dart';

class DLCsCubit extends Cubit<DLCsState> {
  //
  DLCsCubit() : super(DLCsInitState(dlcs: []));

  final repo = GiveawaysRepository();

  bool isInit = false;

  Future<void> errorHandler(dynamic error) async {
    if (error is EmptyException) {
      emit(DLCsEmptyState(emptyMessage: error.message));
    } else if (error is HTTPException) {
      emit(DLCsErrorState(errorMessage: error.message));
    } else if (error is SocketException) {
      emit(DLCsErrorState(errorMessage: 'Connection Error'));
    } else {
      emit(DLCsErrorState(errorMessage: 'Unknown Error'));
    }
  }

  Future<void> getValuableDLCs() async {
    emit(DLCsLoadingState());
    try {
      final data = await repo.getValubaleDLCs();
      isInit = true;
      emit(DLCsUpdateState(dlcs: data));
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> getDLCsbyPlatform({required String platform}) async {
    emit(DLCsLoadingState());
    try {
      final data = await repo.getDlcsbyPlatform(platform: platform);
      isInit = true;
      emit(DLCsUpdateState(dlcs: data));
    } catch (e) {
      errorHandler(e);
    }
  }
}
