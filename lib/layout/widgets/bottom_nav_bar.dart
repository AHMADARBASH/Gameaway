import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';
import '../../blocs/nav_bar_index/index_cubit.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;
    final textstyle =
        GoogleFonts.bebasNeue(fontSize: 12.sp, color: Colors.blue);
    return FadeInUp(
      delay: const Duration(milliseconds: 1000),
      duration: const Duration(milliseconds: 800),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Theme.of(context).shadowColor,
              offset: const Offset(1, 1),
            ),
          ],
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: GNav(
            onTabChange: (index) {
              BlocProvider.of<BottomNavBarCubit>(context)
                  .changeNavBarIndex(index);
            },
            color: textColor,
            activeColor: Colors.grey,
            tabBackgroundColor: Colors.blue.withOpacity(0.2),
            padding: const EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: Typicons.gift,
                iconColor: Colors.grey,
                iconActiveColor: Colors.blue,
                textColor: Colors.blue,
                text: ' Giveaways',
                textStyle: textstyle,
                margin: const EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.gamepad_outlined,
                iconActiveColor: Colors.blue,
                iconColor: Colors.grey,
                textColor: Colors.blue,
                text: ' Free to play',
                textStyle: textstyle,
                margin: const EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.favorite,
                iconActiveColor: Colors.blue,
                iconColor: Colors.grey,
                textColor: Colors.blue,
                text: ' Favorites',
                textStyle: textstyle,
                margin: const EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.newspaper,
                iconActiveColor: Colors.blue,
                iconColor: Colors.grey,
                textColor: Colors.blue,
                text: ' news',
                textStyle: textstyle,
                margin: const EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.settings,
                iconActiveColor: Colors.blue,
                iconColor: Colors.grey,
                textColor: Colors.blue,
                text: ' Settings',
                textStyle: textstyle,
                margin: const EdgeInsets.all(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
