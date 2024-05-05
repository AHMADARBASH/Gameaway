import 'package:gameaway/data/Dataproviders/helpers/cached_data.dart';

abstract class ThemeState {
  String theme;
  ThemeState({required this.theme});
}

class ThemeInitState extends ThemeState {
  ThemeInitState()
      : super(
            theme: CachedData.getData(key: 'theme') == null
                ? "whiteTheme"
                : CachedData.getData(key: 'theme')!);
}

class ChangeThemeState extends ThemeState {
  ChangeThemeState({required super.theme});
}
