// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/DLCs/dlcs_cubit.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_cubit.dart';
import 'package:gameaway/blocs/giveaways/giveaways_cubit.dart';
import 'package:gameaway/blocs/nav_bar_index/index_cubit.dart';
import 'package:gameaway/blocs/news/news_cubit.dart';
import 'package:gameaway/blocs/theme/theme_cubit.dart';
import 'package:gameaway/blocs/theme/theme_state.dart';
import 'package:gameaway/data/helpers/database_helper.dart';
import 'package:gameaway/data/helpers/local_data.dart';
import 'package:gameaway/layout/screens/shared/home_screen.dart';
import 'package:gameaway/utilities/routes.dart';
import 'package:gameaway/utilities/themes.dart';
import 'package:sizer/sizer.dart';
import 'package:gameaway/layout/screens/shared/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DatabaseHelper.createDatabase();
  await LocalData.init();
  await Future.delayed(const Duration(seconds: 1));
  runApp(Gameaway());
}

class Gameaway extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavBarCubit>(
            create: (_) => BottomNavBarCubit(),
          ),
          BlocProvider<GiveawaysCubit>(
            create: (_) => GiveawaysCubit(),
          ),
          BlocProvider<DLCsCubit>(
            create: (_) => DLCsCubit(),
          ),
          BlocProvider<GiveawayFavoritesCubit>(
            create: (_) => GiveawayFavoritesCubit(),
          ),
          BlocProvider<FreetoPlayCubit>(
            create: (_) => FreetoPlayCubit(),
          ),
          BlocProvider<FreetoPlayFavoritesCubit>(
            create: (_) => FreetoPlayFavoritesCubit(),
          ),
          BlocProvider<NewsCubit>(
            create: (_) => NewsCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) => MaterialApp(
            theme: themes[state.theme],
            debugShowCheckedModeBanner: false,
            home: LocalData.containsKey('opened')
                ? HomeScreen()
                : const OnboardingScreen(),
            onGenerateRoute: RouteGenerator.generatedRoute,
          ),
        ),
      ),
    );
  }
}
