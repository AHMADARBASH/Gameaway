import 'package:gameaway/blocs/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/data/Dataproviders/helpers/cached_data.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitState());

  void changeTheme({required String themeName}) {
    CachedData.saveData(key: 'theme', data: themeName);
    emit(ChangeThemeState(theme: themeName));
  }
}
