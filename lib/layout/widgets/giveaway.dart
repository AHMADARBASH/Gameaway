import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_states.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/layout/screens/giveaway/giveaway_deatail_screen.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GiveawayWidget extends StatefulWidget {
  final double width;
  final Giveaway giveaway;
  const GiveawayWidget({
    super.key,
    required this.width,
    required this.giveaway,
  });

  @override
  State<GiveawayWidget> createState() => _GiveawayWidgetState();
}

class _GiveawayWidgetState extends State<GiveawayWidget> {
  Stream<Map<String, dynamic>> getDateDifferent() async* {
    for (int i = 0;; i++) {
      yield {
        'days': DateTime.parse(widget.giveaway.endDate)
            .difference(DateTime.now())
            .inDays,
        'hours': DateTime.parse(widget.giveaway.endDate)
            .difference(DateTime.now())
            .inHours,
        'minutes': DateTime.parse(widget.giveaway.endDate)
                .difference(DateTime.now())
                .inMinutes %
            60,
        'seconds': DateTime.parse(widget.giveaway.endDate)
                .difference(DateTime.now())
                .inSeconds %
            60,
      };
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Theme.of(context).shadowColor,
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(1, 1),
    );
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(GiveawayDetailsScreen.routeName,
            arguments: widget.giveaway);
      },
      child: Column(
        children: [
          //Image Container
          Container(
            padding: EdgeInsets.only(top: 2.sp),
            margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
            width: widget.width,
            height: 26.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(4.sp),
              boxShadow: [boxShadow],
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.giveaway.image,
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                //Price Container
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 8, right: 5, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(
                    widget.giveaway.worth,
                    style: GoogleFonts.bebasNeue(
                        fontSize: context.isTablet ? 10.sp : 12.sp),
                  ),
                ),
                const Spacer(),
                //Favorite Container
                BlocBuilder<GiveawayFavoritesCubit, GiveawayFavoritesState>(
                  builder: (context, state) => Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        state.ids.contains(widget.giveaway.id)
                            ? BlocProvider.of<GiveawayFavoritesCubit>(context)
                                .removeFavorite(id: widget.giveaway.id)
                            : BlocProvider.of<GiveawayFavoritesCubit>(context)
                                .addFavorite(giveaway: widget.giveaway);
                      },
                      icon: Icon(
                        state.ids.contains(widget.giveaway.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
          ),
          //Title Container
          Container(
            height: 18.h,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.sp),
                  padding: EdgeInsets.all(3.sp),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(3.sp),
                    boxShadow: [boxShadow],
                  ),
                  child: Text(
                    widget.giveaway.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: context.isTablet ? 12.sp : 15.sp,
                    ),
                    maxLines: 2,
                  ),
                ),
                //Time Container
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [boxShadow]),
                  child: widget.giveaway.endDate != 'N/A' &&
                          DateTime.parse(widget.giveaway.endDate)
                              .isBefore(DateTime.now())
                      ? Text(
                          'expired',
                          style: GoogleFonts.bebasNeue(
                            fontSize: context.isTablet ? 12.sp : 15.sp,
                          ),
                        )
                      : widget.giveaway.endDate == 'N/A'
                          ? Text(
                              'expire in: N/A',
                              style: GoogleFonts.bebasNeue(
                                fontSize: context.isTablet ? 12.sp : 15.sp,
                              ),
                            )
                          : StreamBuilder(
                              initialData: const {
                                "days": 0,
                                "hours": 0,
                                "minutes": 0,
                                "seconds": 0
                              },
                              stream: getDateDifferent(),
                              builder: (context, snapshot) =>
                                  snapshot.data!['hours'] > 24
                                      ? Text(
                                          'expire in: ${snapshot.data!['days']} days',
                                          style: GoogleFonts.bebasNeue(
                                            fontSize: context.isTablet
                                                ? 12.sp
                                                : 15.sp,
                                          ),
                                          maxLines: 2,
                                        )
                                      : Text(
                                          'expire in: ${snapshot.data?['hours']}:${snapshot.data?['minutes']}:${snapshot.data?['seconds']}',
                                          style: GoogleFonts.bebasNeue(
                                            fontSize: context.isTablet
                                                ? 12.sp
                                                : 15.sp,
                                          ),
                                        ),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
