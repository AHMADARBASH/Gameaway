import 'package:gameaway/blocs/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/data/helpers/local_data.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitState());

  void changeTheme({required String themeName}) {
    LocalData.saveData(key: 'theme', data: themeName);
    emit(ChangeThemeState(theme: themeName));
  }
}
