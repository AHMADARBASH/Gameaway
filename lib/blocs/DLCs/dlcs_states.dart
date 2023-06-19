import 'package:gameaway/data/Models/giveaway.dart';

abstract class DLCsState {
  List<Giveaway> dlcs;
  DLCsState({required this.dlcs});
}

class DLCsInitState extends DLCsState {
  DLCsInitState({required super.dlcs});
}

class DLCsUpdateState extends DLCsState {
  DLCsUpdateState({required super.dlcs});
}

class DLCsLoadingState extends DLCsState {
  DLCsLoadingState() : super(dlcs: []);
}

class DLCsErrorState extends DLCsState {
  String errorMessage;
  DLCsErrorState({required this.errorMessage}) : super(dlcs: []);
}

class DLCsEmptyState extends DLCsState {
  String emptyMessage;
  DLCsEmptyState({required this.emptyMessage}) : super(dlcs: []);
}
