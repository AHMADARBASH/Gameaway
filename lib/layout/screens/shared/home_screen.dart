// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameaway/blocs/nav_bar_index/index_cubit.dart';
import 'package:gameaway/blocs/nav_bar_index/index_state.dart';
import 'package:gameaway/layout/screens/bottom_bar/favotites.dart';
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
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavbarState>(
      builder: (context, state) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            var difference = DateTime.now().difference(timeBackPressed);
            var isExitWarning = difference >= const Duration(seconds: 2);
            timeBackPressed = DateTime.now();
            if (state.index > 0) {
              context.read<BottomNavBarCubit>().changeNavBarIndex(0);
              return false;
            } else if (isExitWarning) {
              Fluttertoast.showToast(msg: 'Press back again to exit');
              return false;
            } else {
              Fluttertoast.cancel();
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
