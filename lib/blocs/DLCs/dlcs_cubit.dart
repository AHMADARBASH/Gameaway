import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/DLCs/dlcs_states.dart';
import '../../data/repositories/giveaways_repository.dart';
import 'package:gameaway/utilities/exceptions.dart';

class DLCsCubit extends Cubit<DLCsState> {
  //
  DLCsCubit()
      : super(DLCsInitState(
          dlcs: [],
        ));

  final repo = GiveawaysRepository();
  bool isInit = false;
  Future<void> getValuableDLCs() async {
    emit(DLCsLoadingState());
    // List<Giveaway> data = [];
    try {
      final data = await repo.getValubaleDLCs();
      isInit = true;
      emit(DLCsUpdateState(dlcs: data));
    } on EmptyException catch (e) {
      emit(DLCsEmptyState(emptyMessage: e.message));
    } on HTTPException catch (e) {
      emit(DLCsErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(DLCsErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      emit(DLCsErrorState(errorMessage: 'Unkown Error'));
    }
  }

  Future<void> getDLCsbyPlatform({required String platform}) async {
    emit(DLCsLoadingState());
    try {
      final data = await repo.getDlcsbyPlatform(platform: platform);
      isInit = true;
      emit(DLCsUpdateState(
        dlcs: data,
      ));
    } on EmptyException catch (e) {
      emit(DLCsEmptyState(emptyMessage: e.message));
    } on HTTPException catch (e) {
      emit(DLCsErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(DLCsErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      emit(DLCsErrorState(errorMessage: _.toString()));
    }
  }
}
