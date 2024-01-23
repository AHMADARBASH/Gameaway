import 'package:animate_do/animate_do.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_states.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_states.dart';
import 'package:gameaway/layout/widgets/freetoplay.dart';
import 'package:gameaway/layout/widgets/giveaway.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<GiveawayFavoritesCubit>(context).getFavorites();
    BlocProvider.of<FreetoPlayFavoritesCubit>(context).getFavorites();
    super.initState();
  }

  bool _isGiveaway = true;
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Favorties',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: context.isTablet ? 12.sp : 20.sp),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                AnimatedPositioned(
                  curve: Curves.easeOutQuart,
                  duration: const Duration(milliseconds: 800),
                  left: _isGiveaway ? 10.w : (context.width / 2),
                  top: 0,
                  bottom: 0,
                  right: _isGiveaway ? (context.width / 2) : 10.w,
                  child: AnimatedContainer(
                    curve: Curves.easeOutQuart,
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isGiveaway = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: Text(
                          'Giveaways',
                          style: GoogleFonts.bebasNeue(fontSize: 15.sp),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isGiveaway = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: Text(
                          'Free to play',
                          style: GoogleFonts.bebasNeue(fontSize: 15.sp),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            _isGiveaway
                ? BlocBuilder<GiveawayFavoritesCubit, GiveawayFavoritesState>(
                    builder: (context, state) => FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: state is GiveawayFavoritesEmptyState
                          ? Column(
                              children: [
                                Image.asset(
                                  'assets/images/void.png',
                                  height: 130.sp,
                                ),
                                Text(
                                  'you don\'t have favorite items',
                                  style: GoogleFonts.bebasNeue(fontSize: 15.sp),
                                )
                              ],
                            )
                          : SizedBox(
                              height: 170.sp,
                              child: ListView.builder(
                                itemCount: state.favorites.length,
                                itemBuilder: (context, index) => GiveawayWidget(
                                  width: 95.w,
                                  giveaway: state.favorites[index],
                                ),
                              ),
                            ),
                    ),
                  )
                : BlocBuilder<FreetoPlayFavoritesCubit,
                    FreetoPlayFavoritesState>(
                    builder: (context, state) => FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: state is FreetoPlayFavoritesEmptyState
                          ? Column(
                              children: [
                                Image.asset(
                                  'assets/images/void.png',
                                  height: 130.sp,
                                ),
                                Text(
                                  'you don\'t have favorite items',
                                  style: GoogleFonts.bebasNeue(fontSize: 15.sp),
                                )
                              ],
                            )
                          : SizedBox(
                              height: 145.sp,
                              child: ListView.builder(
                                itemCount: state.favorites.length,
                                itemBuilder: (context, index) =>
                                    FreetoPlayWidget(
                                  width: 95.w,
                                  freetoPlay: state.favorites[index],
                                ),
                              ),
                            ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
