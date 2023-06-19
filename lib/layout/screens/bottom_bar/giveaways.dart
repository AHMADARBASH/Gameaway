import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gameaway/blocs/DLCs/dlcs_cubit.dart';
import 'package:gameaway/blocs/DLCs/dlcs_states.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/giveaways/giveaways_cubit.dart';
import 'package:gameaway/blocs/giveaways/giveaways_states.dart';
import 'package:gameaway/layout/screens/giveaway/more_dlcs_screen.dart';
import 'package:gameaway/layout/screens/giveaway/more_giveaways_screen.dart';
import 'package:gameaway/layout/widgets/giveaway.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../data/constants/platforms.dart';

class GiveawaysScreen extends StatefulWidget {
  const GiveawaysScreen({super.key});

  @override
  State<GiveawaysScreen> createState() => _GiveawaysScreenState();
}

class _GiveawaysScreenState extends State<GiveawaysScreen> {
  @override
  void initState() {
    if (BlocProvider.of<GiveawaysCubit>(context).isInit == false) {
      BlocProvider.of<GiveawaysCubit>(context).getValuableGiveaways();
    }
    if (BlocProvider.of<DLCsCubit>(context).isInit == false) {
      BlocProvider.of<DLCsCubit>(context).getValuableDLCs();
    }
    BlocProvider.of<GiveawayFavoritesCubit>(context).getFavorites();
    super.initState();
  }

  int platformIndex = 0;
  String platformName = '';

  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Theme.of(context).shadowColor,
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(1, 1),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                curve: Curves.easeOutQuart,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Platforms',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20.sp),
                ),
              ),
              BlocBuilder<DLCsCubit, DLCsState>(
                builder: (context, dlcsState) =>
                    BlocBuilder<GiveawaysCubit, GiveawaysState>(
                  builder: (context, state) => FadeInDown(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutQuart,
                    child: StatefulBuilder(
                      builder: (context, newSetState) => Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: platforms.length,
                              itemBuilder: (context, index) => InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () async {
                                  if (state is GiveawayLoadingState ||
                                      dlcsState is DLCsLoadingState) {
                                    return;
                                  }
                                  if (platformIndex ==
                                      platforms[index]['index']) {
                                    platformIndex = 0;
                                    platformName = '';
                                    newSetState(() {});
                                    BlocProvider.of<GiveawaysCubit>(context)
                                        .getValuableGiveaways();
                                    BlocProvider.of<DLCsCubit>(context)
                                        .getValuableDLCs();
                                  } else {
                                    platformIndex = platforms[index]['index'];
                                    platformName = platforms[index]['name'];
                                    newSetState(() {});
                                    BlocProvider.of<GiveawaysCubit>(context)
                                        .getGiveawaysbyPlatform(
                                            platform: platforms[index]
                                                ['value']);
                                    BlocProvider.of<DLCsCubit>(context)
                                        .getDLCsbyPlatform(
                                            platform: platforms[index]
                                                ['value']);
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.all(4),
                                  padding: const EdgeInsets.only(
                                      right: 8, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: platformIndex ==
                                              platforms[index]['index']
                                          ? Border.all(
                                              color: Colors.blue, width: 2)
                                          : Border.all(
                                              color: Colors.transparent,
                                              width: 1),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      boxShadow: [boxShadow]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                        width: 45.sp,
                                        height: 45.sp,
                                        child: Center(
                                          child: Image.asset(
                                            platforms[index]['logo'],
                                            width: 30,
                                            height: 30,
                                            color: platforms[index]['color'],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' ${platforms[index]['name']}',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                platformName == ''
                                    ? 'Most Valuebale'
                                    : platformName,
                                style: GoogleFonts.bebasNeue(fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 500),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [boxShadow]),
                    child: Text('Games',
                        style: GoogleFonts.bebasNeue(fontSize: 15.sp))),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 500),
                child: BlocBuilder<GiveawaysCubit, GiveawaysState>(
                  builder: (context, state) {
                    if (state is GiveawayErrorState) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/error.png',
                              width: 70.w,
                              height: 30.h,
                            ),
                            Text(
                              state.errorMessage,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<GiveawaysCubit>(context)
                                    .getValuableGiveaways();
                                BlocProvider.of<DLCsCubit>(context)
                                    .getValuableDLCs();
                              },
                              icon: Icon(
                                Icons.restart_alt,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is GiveawayLoadingState) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            const SpinKitFadingCircle(
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      );
                    } else if (state is GiveawayEmptyState) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/void.png',
                              width: 70.w,
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              state.emptyMessage,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 45.h,
                        width: 100.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.giveaways.length > 6
                              ? 6
                              : state.giveaways.length,
                          itemBuilder: (context, index) =>
                              state.giveaways.length > 6 && index == 5
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: 1.h, bottom: 5.h, left: 2.h),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [boxShadow]),
                                      width: 20.w,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              MoreGiveawaysScreen.routeName,
                                              arguments: {
                                                'platform': platformName == ''
                                                    ? 'most valuable'
                                                    : platformName
                                              });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const CircleAvatar(
                                                child: Icon(
                                              Icons.double_arrow,
                                              color: Colors.white,
                                            )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'See More',
                                              style: GoogleFonts.bebasNeue(
                                                  fontSize: 15.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : GiveawayWidget(
                                      width: 80.w,
                                      giveaway: state.giveaways[index],
                                    ),
                        ),
                      );
                    }
                  },
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 800),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [boxShadow]),
                  child: Text(
                    'DLC',
                    style: GoogleFonts.bebasNeue(fontSize: 15.sp),
                  ),
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 800),
                child: BlocBuilder<DLCsCubit, DLCsState>(
                  builder: (context, state) {
                    if (state is DLCsErrorState) {
                      return const Center(
                        child: Text(''),
                      );
                    } else if (state is DLCsLoadingState) {
                      return const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                        ),
                      );
                    } else if (state is DLCsEmptyState) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/void.png',
                              width: 70.w,
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              state.emptyMessage,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 45.h,
                        width: 100.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              state.dlcs.length > 6 ? 6 : state.dlcs.length,
                          itemBuilder: (context, index) =>
                              state.dlcs.length > 6 && index == 5
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: 1.h, bottom: 5.h, left: 2.h),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [boxShadow]),
                                      width: 20.w,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              MoreDLCsScreen.routeName,
                                              arguments: {
                                                'platform': platformName == ''
                                                    ? 'most valuable'
                                                    : platformName
                                              });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.blue[600],
                                              child: const Icon(
                                                Icons.double_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'See More',
                                              style: GoogleFonts.bebasNeue(
                                                  fontSize: 15.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : GiveawayWidget(
                                      width: 80.w,
                                      giveaway: state.dlcs[index],
                                    ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
