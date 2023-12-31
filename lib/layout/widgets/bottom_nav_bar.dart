import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
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
    final activeIndex = context.watch<BottomNavBarCubit>().state.index;
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;
    final textstyle = GoogleFonts.bebasNeue(
        fontSize: context.isTablet ? 14.sp : 12.sp,
        color: context.primaryColor);

    return FadeInUp(
      delay: const Duration(milliseconds: 1000),
      duration: const Duration(milliseconds: 800),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
        padding: EdgeInsets.symmetric(vertical: 4.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sp),
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
        child: GNav(
          selectedIndex: activeIndex,
          onTabChange: (index) {
            BlocProvider.of<BottomNavBarCubit>(context)
                .changeNavBarIndex(index);
          },
          iconSize: 12.sp,
          haptic: true,
          color: textColor,
          activeColor: Colors.grey,
          tabBackgroundColor: context.primaryColor.withOpacity(0.2),
          tabs: [
            GButton(
              margin: EdgeInsets.only(left: 4.sp),
              padding: EdgeInsets.all(8.sp),
              icon: Typicons.gift,
              iconColor: Colors.grey,
              iconActiveColor: context.primaryColor,
              textColor: context.primaryColor,
              text: ' Giveaways',
              textStyle: textstyle,
              haptic: true,
            ),
            GButton(
              padding: EdgeInsets.all(8.sp),
              icon: Icons.gamepad_outlined,
              iconActiveColor: context.primaryColor,
              iconColor: Colors.grey,
              textColor: context.primaryColor,
              text: ' Free to play',
              textStyle: textstyle,
              haptic: true,
            ),
            GButton(
              padding: EdgeInsets.all(8.sp),
              icon: Icons.favorite,
              iconActiveColor: context.primaryColor,
              iconColor: Colors.grey,
              textColor: context.primaryColor,
              text: ' Favorites',
              textStyle: textstyle,
              haptic: true,
            ),
            GButton(
              padding: EdgeInsets.all(8.sp),
              icon: Icons.newspaper,
              iconActiveColor: context.primaryColor,
              iconColor: Colors.grey,
              textColor: context.primaryColor,
              text: ' news',
              textStyle: textstyle,
              haptic: true,
            ),
            GButton(
              margin: EdgeInsets.only(right: 4.sp),
              padding: EdgeInsets.all(8.sp),
              icon: Icons.settings,
              iconActiveColor: context.primaryColor,
              iconColor: Colors.grey,
              textColor: context.primaryColor,
              text: ' Settings',
              textStyle: textstyle,
              haptic: true,
            ),
          ],
        ),
      ),
    );
  }
}
