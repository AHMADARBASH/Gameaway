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
import 'package:gameaway/layout/screens/shared/home_screen.dart';
import 'package:gameaway/layout/widgets/category_widget.dart';
import 'package:gameaway/layout/widgets/giveaway.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:gameaway/utilities/widget_extenstion.dart';
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
    HomeScreen.timeBackPressed =
        DateTime.now().subtract(const Duration(seconds: 3));
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
              SizedBox(
                height: 1.h,
              ),
              FadeInDown(
                curve: Curves.easeOutQuart,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Platforms',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: context.isTablet ? 10.sp : 20.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              //Top Categories List
              BlocBuilder<DLCsCubit, DLCsState>(
                builder: (context, dlcsState) =>
                    BlocBuilder<GiveawaysCubit, GiveawaysState>(
                  builder: (context, state) => FadeInDown(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuart,
                    child: StatefulBuilder(
                      builder: (context, newSetState) => Column(
                        children: [
                          SizedBox(
                            height: context.isTablet ? 5.h : 7.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: platforms.length,
                              itemBuilder: (context, index) => CategoryWidget(
                                index: index,
                                globalIndex: platformIndex,
                                categories: platforms,
                              ).bounce(
                                onPressed: () {
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
                                duration: Duration(milliseconds: 100),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                platformName == ''
                                    ? 'Most Valuebale'
                                    : platformName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize:
                                            context.isTablet ? 10.sp : 20.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 500),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [boxShadow]),
                  child: Text(
                    'Games',
                    style: GoogleFonts.bebasNeue(
                      fontSize: context.isTablet ? 10.sp : 15.sp,
                    ),
                  ),
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 400),
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
                                  fontSize: context.isTablet ? 20.sp : 15.sp,
                                  fontWeight: FontWeight.bold),
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
                            SpinKitFadingCircle(
                              color: context.primaryColor,
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
                                fontSize: context.isTablet ? 20.sp : 15.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: context.isTablet ? 46.h : 50.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.giveaways.length > 6
                              ? 6
                              : state.giveaways.length,
                          itemBuilder: (context, index) =>
                              state.giveaways.length > 6 && index == 5
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp),
                                      margin: EdgeInsets.only(
                                          top: 1.h, bottom: 5.h, left: 2.h),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [boxShadow]),
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
                                                  fontSize: context.isTablet
                                                      ? 10.sp
                                                      : 15.sp),
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
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [boxShadow]),
                  child: Text(
                    'DLC',
                    style: GoogleFonts.bebasNeue(
                        fontSize: context.isTablet ? 10.sp : 15.sp),
                  ),
                ),
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 600),
                child: BlocBuilder<DLCsCubit, DLCsState>(
                  builder: (context, state) {
                    if (state is DLCsErrorState) {
                      return const Center(
                        child: Text(''),
                      );
                    } else if (state is DLCsLoadingState) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: context.primaryColor,
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
                        height: context.isTablet ? 46.h : 50.h,
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
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [boxShadow],
                                      ),
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
                                              backgroundColor:
                                                  context.primaryColor[600],
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
                                                  fontSize: context.isTablet
                                                      ? 10.sp
                                                      : 15.sp),
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
