import 'package:gameaway/data/Models/freetoplay.dart';

abstract class FreetoPlayState {
  List<FreetoPlay> freetoplay;
  FreetoPlayState({required this.freetoplay});
}

class FreetoPlayInitState extends FreetoPlayState {
  FreetoPlayInitState({required super.freetoplay});
}

class FreetoPlayUpadateState extends FreetoPlayState {
  FreetoPlayUpadateState({required super.freetoplay});
}

class FreetoPlayLoadingState extends FreetoPlayState {
  FreetoPlayLoadingState() : super(freetoplay: []);
}

class FreetoPlayErrorState extends FreetoPlayState {
  String errorMessage;
  FreetoPlayErrorState({required this.errorMessage}) : super(freetoplay: []);
}

class FreetoPlayEmptyState extends FreetoPlayState {
  String emptyMessage;
  FreetoPlayEmptyState({required this.emptyMessage}) : super(freetoplay: []);
}
