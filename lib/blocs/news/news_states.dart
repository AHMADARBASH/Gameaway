import 'package:gameaway/data/Models/news.dart';

abstract class NewsState {
  List<News> news;
  NewsState({required this.news});
}

class NewsInitState extends NewsState {
  NewsInitState() : super(news: []);
}

class NewsLoadingState extends NewsState {
  NewsLoadingState() : super(news: []);
}

class NewsErrorState extends NewsState {
  String errorMessage;
  NewsErrorState({required this.errorMessage}) : super(news: []);
}

class NewsEmptyState extends NewsState {
  NewsEmptyState() : super(news: []);
}

class NewsUpdatedState extends NewsState {
  NewsUpdatedState({required super.news});
}
