import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_states.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/layout/screens/freetoplay/freetoplay_details_screen.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:gameaway/utilities/widget_extenstion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FreetoPlayWidget extends StatefulWidget {
  final double width;
  final FreetoPlay freetoPlay;
  const FreetoPlayWidget({
    super.key,
    required this.width,
    required this.freetoPlay,
  });

  @override
  State<FreetoPlayWidget> createState() => _FreetoPlayWidgetState();
}

class _FreetoPlayWidgetState extends State<FreetoPlayWidget> {
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
        Navigator.of(context).pushNamed(FreetoPlayDetailsScreen.routeName,
            arguments: widget.freetoPlay);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2.sp),
            margin: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
            width: widget.width,
            height: 25.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(5.sp),
              boxShadow: [boxShadow],
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.freetoPlay.thumbnail,
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 8, right: 5, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.sp),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(
                    widget.freetoPlay.developer,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: context.isTablet ? 10.sp : 12.sp),
                  ),
                ),
                const Spacer(),
                BlocBuilder<FreetoPlayFavoritesCubit, FreetoPlayFavoritesState>(
                  builder: (context, state) => Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      state.ids.contains(widget.freetoPlay.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: context.primaryColor,
                    ),
                  ).bounce(
                      onPressed: () {
                        state.ids.contains(widget.freetoPlay.id)
                            ? BlocProvider.of<FreetoPlayFavoritesCubit>(context)
                                .removeFavorite(id: widget.freetoPlay.id)
                            : BlocProvider.of<FreetoPlayFavoritesCubit>(context)
                                .addFavorite(freetoplay: widget.freetoPlay);
                      },
                      duration: Duration(milliseconds: 100)),
                )
              ],
            ),
          ),
          Container(
            height: 10.h,
            width: widget.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [boxShadow]),
                  child: Text(
                    widget.freetoPlay.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: context.isTablet ? 12.sp : 15.sp,
                    ),
                    maxLines: 2,
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
