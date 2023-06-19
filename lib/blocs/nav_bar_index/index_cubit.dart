// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:gameaway/blocs/nav_bar_index/index_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavbarState> {
  BottomNavBarCubit() : super(BottomNavBarInitState());

  void changeNavBarIndex(int index) {
    emit(BottomNavBarChangeIndexState(index: index));
  }
}
