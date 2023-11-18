import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/news/news_states.dart';
import 'package:gameaway/data/repositories/news_reposiroty.dart';
import 'package:gameaway/utilities/exceptions.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitState());

  final repo = NewsRepository();
  bool isInit = false;
  Future<void> getNews() async {
    emit(NewsLoadingState());
    try {
      final data = await repo.getAllNews();
      isInit = true;
      emit(NewsUpdatedState(news: data));
    } on EmptyException catch (_) {
      emit(NewsEmptyState());
    } on HTTPException catch (e) {
      emit(NewsErrorState(errorMessage: e.message));
    } on SocketException catch (_) {
      emit(NewsErrorState(errorMessage: 'Connection Error'));
    } catch (_) {
      print('-----------------------------------\n ${_.toString()}');
      emit(NewsErrorState(errorMessage: 'Unkown Error'));
    }
  }
}
