import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_cubit.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_states.dart';
import 'package:gameaway/data/constants/categories.dart';
import 'package:gameaway/layout/screens/freetoplay/more_freetoplay_screen.dart';
import 'package:gameaway/layout/widgets/freetoplay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FreetoPlayScreen extends StatefulWidget {
  const FreetoPlayScreen({super.key});

  @override
  State<FreetoPlayScreen> createState() => _FreetoPlayScreenState();
}

class _FreetoPlayScreenState extends State<FreetoPlayScreen> {
  @override
  void initState() {
    if (BlocProvider.of<FreetoPlayCubit>(context).isInit == false) {
      BlocProvider.of<FreetoPlayCubit>(context).getFreetoplay();
    }
    BlocProvider.of<GiveawayFavoritesCubit>(context).getFavorites();
    super.initState();
  }

  int categoryIndex = 0;
  String categotyName = '';

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
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                curve: Curves.easeOutQuart,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Categories',
                  style: GoogleFonts.bebasNeue(fontSize: 20.sp),
                ),
              ),
              BlocBuilder<FreetoPlayCubit, FreetoPlayState>(
                builder: (context, state) => FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutQuart,
                  child: StatefulBuilder(
                    builder: (context, newSetState) => Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) => InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () async {
                                if (state is FreetoPlayLoadingState) {
                                  return;
                                }
                                if (categoryIndex ==
                                    categories[index]['index']) {
                                  categoryIndex = 0;
                                  categotyName = '';
                                  newSetState(() {});
                                  BlocProvider.of<FreetoPlayCubit>(context)
                                      .getFreetoplay();
                                } else {
                                  categoryIndex = categories[index]['index'];
                                  categotyName = categories[index]['name'];
                                  newSetState(() {});
                                  BlocProvider.of<FreetoPlayCubit>(context)
                                      .getFreetoPlaybyCategory(
                                          category: categories[index]['name']);
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.only(
                                    right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: categoryIndex ==
                                            categories[index]['index']
                                        ? Border.all(
                                            color: Colors.blue, width: 2)
                                        : Border.all(
                                            color: Colors.transparent,
                                            width: 1),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                      width: 40.sp,
                                      height: 40.sp,
                                      child: Center(
                                        child: Image.asset(
                                          categories[index]['logo'],
                                          width: 25.sp,
                                          height: 20.sp,
                                          color: categories[index]['color'],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' ${categories[index]['name']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              categotyName == '' ? 'All' : categotyName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 20.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 500),
                child: BlocBuilder<FreetoPlayCubit, FreetoPlayState>(
                  builder: (context, state) {
                    if (state is FreetoPlayErrorState) {
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
                                BlocProvider.of<FreetoPlayCubit>(context)
                                    .getFreetoplay();
                              },
                              icon: Icon(
                                Icons.restart_alt,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is FreetoPlayLoadingState) {
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
                    } else if (state is FreetoPlayEmptyState) {
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
                            Text(state.emptyMessage,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 20.sp)),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 67.h,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: state.freetoplay.length > 6
                              ? 6
                              : state.freetoplay.length,
                          itemBuilder: (context, index) =>
                              state.freetoplay.length > 6 && index == 5
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: 1.h, bottom: 5.h, left: 2.h),
                                      padding: EdgeInsets.all(1.h),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [boxShadow]),
                                      width: 100.w,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              MoreFreetoPlayScreen.routeName,
                                              arguments: categotyName);
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
                                  : FreetoPlayWidget(
                                      width: 95.w,
                                      freetoPlay: state.freetoplay[index],
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
