import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/news/news_states.dart';
import 'package:gameaway/data/repositories/news_reposiroty.dart';
import 'package:gameaway/utilities/exceptions.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitState());

  final repo = NewsRepository();

  bool isInit = false;

  Future<void> errorHandler(dynamic error) async {
    if (error is EmptyException) {
      emit(NewsEmptyState());
    } else if (error is HTTPException) {
      emit(NewsErrorState(errorMessage: error.message));
    } else if (error is SocketException) {
      emit(NewsErrorState(errorMessage: 'Connection Error'));
    } else {
      emit(NewsErrorState(errorMessage: 'Unknown Error'));
    }
  }

  Future<void> getNews() async {
    emit(NewsLoadingState());
    try {
      final data = await repo.getAllNews();
      isInit = true;
      emit(NewsUpdatedState(news: data));
    } catch (e) {
      errorHandler(e);
    }
  }
}
