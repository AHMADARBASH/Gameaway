// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/nav_bar_index/index_cubit.dart';
import 'package:gameaway/blocs/nav_bar_index/index_state.dart';
import 'package:gameaway/layout/screens/bottom_bar/favotites.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';
import '../bottom_bar/free_to_play.dart';
import 'package:gameaway/layout/screens/bottom_bar/giveaways.dart';
import 'package:gameaway/layout/screens/bottom_bar/settings.dart';
import 'package:gameaway/layout/widgets/bottom_nav_bar.dart';
import '../../screens/bottom_bar/news_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  HomeScreen({super.key});
  final List<Widget> _pages = [
    const GiveawaysScreen(),
    const FreetoPlayScreen(),
    const FavoritesScreen(),
    const NewsScreen(),
    const SettingsScreen(),
  ];
  static DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavbarState>(
      builder: (context, state) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            int difference =
                DateTime.now().difference(timeBackPressed).inSeconds;
            bool isExitWarning = difference >= 3;
            timeBackPressed = DateTime.now();
            if (state.index > 0) {
              context.read<BottomNavBarCubit>().changeNavBarIndex(0);
              return false;
            } else if (isExitWarning) {
              toastification.dismissAll();
              toastification.show(
                  title: Text(
                    'Press back again to exit',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15.sp),
                  ),
                  showProgressBar: true,
                  progressBarTheme: ProgressIndicatorThemeData(
                    color: context.primaryColor,
                    linearMinHeight: 4,
                    circularTrackColor: context.primaryColor,
                  ),
                  type: ToastificationType.warning,
                  style: ToastificationStyle.flatColored,
                  alignment: Alignment.bottomCenter,
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: context.canvasColor,
                  primaryColor: context.primaryColor,
                  autoCloseDuration: const Duration(seconds: 3),
                  foregroundColor: Colors.white,
                  applyBlurEffect: true);
              return false;
            } else {
              toastification.dismissAll();
              return true;
            }
          },
          child: Scaffold(
            body: _pages[state.index],
            bottomNavigationBar: const NavBar(),
          ),
        ),
      ),
    );
  }
}
